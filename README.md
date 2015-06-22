# aws-backup
## Purpose
To fully automate the backup and exporting of our databases for development and backup usage.  The files will then be copied over the defined VPN to an internal server for storage and removed from the export host.

### Things this does for you.
1. The script will find the most recent snapshot for the instance you you are setting.
2. It will then mount this into an RDS instance and return the new DB ENDPOINT for the instance.
3. It will do a full dump of the database without making any sanitizations
4. It will copy this up to the specified file share into a secured folder that is available.
5. It will then sanitizer the database through the selected sanitizer file in the sanitizer folder
6. It will export the sanitized version to the developer share which all developers should have access to.
7. It will then delete the RDS instance it created and clean up after itself.  This will leave the last 5 current backups for sanitized versions available on the server.  If you need to be working from a certain snapshot, then be sure to make a local copy before the 5 day window passes otherwise these will be removed.

## Folder Structure Explained
There are 3 primary folders included in the root of the project.

Logs - This is obvious I would think.  This script will log to the console, as well as a script specific log in the log folder for reference once it is running automation and you are not monitoring the output.

Sanitizers - These are used to sanitize the database before exporting the developer copies.


## Change Log
June 22 - Initial Release.

## Suggestions
If you have a suggestion for a change or a bug fix, please fork and submit a pull request.
