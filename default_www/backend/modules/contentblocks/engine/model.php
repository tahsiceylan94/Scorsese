<?php

/**
 * BackendContentblocksModel
 * In this file we store all generic functions that we will be using in the ContentblocksModule
 *
 * @package		backend
 * @subpackage	contentblocks
 *
 * @author 		Davy Hellemans <davy@netlash.com>
 * @author 		Tijs Verkoyen <tijs@netlash.com>
 * @since		2.0
 */
class BackendContentblocksModel
{
	// overview of the items
	const QRY_BROWSE = 'SELECT c.id, c.title
						FROM contentblocks AS c
						WHERE c.status = ?;';


	// overview of the revisions for an item
	const QRY_BROWSE_REVISIONS = 'SELECT c.id, c.revision_id, c.title, UNIX_TIMESTAMP(c.edited_on) AS edited_on
									FROM contentblocks AS c
									WHERE c.status = ? AND c.id = ?
									ORDER BY c.edited_on DESC;';


	/**
	 * Delete a contentblocks-item
	 *
	 * @return	void
	 * @param	int $id		The id of the record to delete.
	 */
	public static function delete($id)
	{
		// redefine
		$id = (int) $id;

		// get db
		$db = BackendModel::getDB(true);

		// delete all records
		$db->delete('contentblocks', 'id = ?', $id);
	}


	/**
	 * Does the contentblocks-item exists
	 *
	 * @return	bool
	 * @param	int $id							The id of the record to check for existence.
	 * @param	bool[optional] $activeOnly		Only check in active items?
	 */
	public static function exists($id, $activeOnly = true)
	{
		// redefine
		$id = (int) $id;
		$activeOnly = (bool) $activeOnly;

		// get db
		$db = BackendModel::getDB();

		// if the item should also be active, there should be at least one row to return true
		if($activeOnly) return ($db->getNumRows('SELECT c.id
												FROM contentblocks AS c
												WHERE c.id = ? AND c.status = ?;',
												array($id, 'active')) >= 1);

		// fallback, this doesn't take the active status in account
		return ($db->getNumRows('SELECT c.id
									FROM contentblocks AS c
									WHERE c.revision_id = ?;',
									array($id)) >= 1);
	}


	/**
	 * Get all data for a given id
	 *
	 * @return	array
	 * @param	int $id		The ID for the record to get.
	 */
	public static function get($id)
	{
		// redefine
		$id = (int) $id;

		// get db
		$db = BackendModel::getDB();

		// get record and return it
		return (array) $db->getRecord('SELECT c.*, UNIX_TIMESTAMP(created_on) AS created_on, UNIX_TIMESTAMP(edited_on) AS edited_on
										FROM contentblocks AS c
										WHERE c.id = ? AND c.status = ?
										LIMIT 1;',
										array($id, 'active'));
	}


	/**
	 * Get all data for a given revision
	 *
	 * @return	array
	 * @param	int $id				The Id for the item wherefor you want a revision.
	 * @param	int $revisionId		The Id of the revision.
	 */
	public static function getRevision($id, $revisionId)
	{
		// redefine
		$id = (int) $id;
		$revisionId = (int) $revisionId;

		// get db
		$db = BackendModel::getDB();

		// get record and return it
		return (array) $db->getRecord('SELECT c.*, UNIX_TIMESTAMP(created_on) AS created_on, UNIX_TIMESTAMP(edited_on) AS edited_on
										FROM contentblocks AS c
										WHERE c.id = ? AND c.revision_id = ?
										LIMIT 1;',
										array($id, $revisionId));
	}


	/**
	 * Add a new snippet-item
	 *
	 * @return	int
	 * @param	array $values		The data to insert.
	 */
	public static function insert(array $values)
	{
		// get db
		$db = BackendModel::getDB(true);

		// calculate new id
		$newId = (int) $db->getVar('SELECT MAX(id) FROM contentblocks LIMIT 1;') + 1;

		// build array
		$values['id'] = $newId;
		$values['user_id'] = BackendAuthentication::getUser()->getUserId();
		$values['language'] = BL::getWorkingLanguage();
		$values['hidden'] = ($values['hidden']) ? 'N' : 'Y';
		$values['status'] = 'active';
		$values['created_on'] = BackendModel::getUTCDate();
		$values['edited_on'] = BackendModel::getUTCDate();

		// insert and return the insertId
		$db->insert('contentblocks', $values);

		// build array
		$extra['module'] = 'contentblocks';
		$extra['type'] = 'widget';
		$extra['label'] = 'ContentBlocks';
		$extra['action'] = 'detail';
		$extra['data'] = serialize(array('extra_label' => $values['title'], 'id' => $newId));
		$extra['hidden'] = 'N';
		$extra['sequence'] = '200'. $newId;

		// insert extra
		$db->insert('pages_extras', $extra);

		// insert the new id
		return $newId;
	}


	/**
	 * Update an existing snippet-item
	 *
	 * @return	int
	 * @param	int $id				The Id for the item to update.
	 * @param	array $values		The new data.
	 */
	public static function update($id, array $values)
	{
		// redefine
		$id = (int) $id;

		// get db
		$db = BackendModel::getDB(true);

		// get current version
		$version = self::get($id);

		// build array
		$values['id'] = $id;
		$values['user_id'] = BackendAuthentication::getUser()->getUserId();
		$values['language'] = $version['language'];
		$values['hidden'] = ($values['hidden']) ? 'N' : 'Y';
		$values['status'] = 'active';
		$values['created_on'] = BackendModel::getUTCDate('Y-m-d H:i:s', $version['created_on']);
		$values['edited_on'] = BackendModel::getUTCDate();

		// archive all older versions
		$db->update('contentblocks', array('status' => 'archived'), 'id = ?', array($id));

		// insert new version
		$db->insert('contentblocks', $values);

		// how many revisions should we keep
		$rowsToKeep = (int) BackendModel::getSetting('contentblocks', 'maximum_number_of_revisions', 5);

		// get revision-ids for items to keep
		$revisionIdsToKeep = (array) $db->getColumn('SELECT c.revision_id
														FROM contentblocks AS c
														WHERE c.id = ? AND c.status = ?
														ORDER BY c.edited_on DESC
														LIMIT ?;',
														array($id, 'archived', $rowsToKeep));

		// delete other revisions
		if(!empty($revisionIdsToKeep)) $db->delete('contentblocks', 'id = ? AND status = ? AND revision_id NOT IN('. implode(', ', $revisionIdsToKeep) .')', array($id, 'archived'));

		// build array
		$extra['data'] = serialize(array('extra_label' => $values['title'], 'id' => $id));

		// update extra
		$db->update('pages_extras', $extra, 'module = ? AND type = ? AND sequence = ?', array('contentblocks', 'widget', '200'. $id));

		// return id
		return $id;
	}
}

?>