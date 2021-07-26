-- a. Insert a new folder or file at any level (root or inside a folder)

-- add root folder
insert into "Folder" ("name", "folderId") values (
	'Root', (select last_value from "Folder_id_seq")
);

-- add other folders & files
insert into "Folder" ("name", "folderId") values ('Folder1', 1);
insert into "File" ("name", "format", "size", "dimensions", "folderId") values ('File1', 'PNG', 500, '120x120', 2);

-- b. Get list of all files reverse sorted by date
select * from "File" order by "createdAt" desc;

-- c. Find the total size of a folder like total size of files contained in Folder2 which would include size of files File3.jpg and File4.txt

select SUM("size") from "File" where "folderId" in (
WITH RECURSIVE folders AS (
	SELECT
		id
	FROM
		"Folder"
	WHERE
		"folderId" = 1
	UNION
		SELECT
			f.id
		FROM
			"Folder" f
		INNER JOIN folders s ON s.id = f."folderId"
) SELECT
	*
FROM
	folders
);


-- d. Delete a folder
DELETE FROM "Folder" where id = 1;

-- e. Search by filename
select * from "File" where "name" = 'File1';

-- f. Search for files with name “File1” and format = PNG
select * from "File" where "name" = 'File1' and "format" = 'PNG';

-- g. Rename SubFolder2 to NestedFolder2
update "Folder" set "name" = 'NestedFolder2' where "name" = 'SubFolder2';
