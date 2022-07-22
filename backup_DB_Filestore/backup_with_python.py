import os
import time
import subprocess

dump_dir = '/home/openerp/db_backup'
db_username = 'openerp'
#db_password = ''
db_names = ['DB_NAME']

for db_name in db_names:
    try:
        file_path = ''
        dumper = " -U %s --password -Z 9 -f %s -F c %s  "
#        os.putenv('PGPASSWORD', db_password)
        bkp_file = '%s_%s.sql' % (db_name, time.strftime('%Y%m%d_%H_%M_%S'))
#        glob_list = glob.glob(dump_dir + db_name + '*' + '.pgdump')
        file_path = os.path.join(dump_dir, bkp_file)
        command = 'pg_dump' + dumper % (db_username, file_path, db_name)
        subprocess.call(command, shell=True)
        subprocess.call('gzip ' + file_path, shell=True)
    except:
        print "Couldn't backup database" % (db_name)
