from xlutils.copy import copy # http://pypi.python.org/pypi/xlutils
from xlrd import open_workbook # http://pypi.python.org/pypi/xlrd
from xlwt import easyxf # http://pypi.python.org/pypi/xlwt

import uuid
import os

from hashids import Hashids
hashids = Hashids(salt='why do we have hacker friends', min_length=6, alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')

def random_code(string_length=6):
    """Returns a random string of length string_length."""
    random = str(uuid.uuid4()) # Convert UUID format to a Python string.
    random = random.upper() # Make all characters uppercase.
    random = random.replace("-","") # Remove the UUID '-'.
    candidate = random[0:string_length] # Return the random string.
    if (candidate.find('E') != -1) or (candidate.find('0') != -1) or (candidate.find('O') != -1):
      print 'going to recruse on ', candidate
      candidate = random_code(string_length)
    return candidate


def write_code_col(file_path):
    START_ROW = 2 # 0 based (subtract 1 from excel row number)
    col_invitation_to = 5
    col_invite_group = 3
    col_6_digit_code = 26
    invite_groups = {}
    object_of_hash_ids = {}
    count = 0

    rb = open_workbook(file_path)
    r_sheet = rb.sheet_by_index(0) # read only copy to introspect the file
    wb = copy(rb) # a writable copy (I can't read values out of this, only write to it)
    w_sheet = wb.get_sheet(0) # the sheet to write to within the writable copy

    for row_index in range(START_ROW, r_sheet.nrows):
        count += 1

        invite_group = r_sheet.cell(row_index, col_invite_group).value
        print 'invite group', invite_group
        hashid = random_code()
        if hashid in object_of_hash_ids:
          print '!!! why are there duplicates?', hashid, 'for group ', invite_group

        if r_sheet.cell(row_index, col_invitation_to).value != '':
            invite_groups[invite_group] = hashid
            object_of_hash_ids[hashid] = True

            print "writing code", hashid, 'to invite group', invite_group
            w_sheet.write(row_index, col_6_digit_code, hashid)
            count = 0

    print 'num keys', len(invite_groups.keys())
    print 'num hashes', len(object_of_hash_ids.keys())
    wb.save(file_path + '.out' + os.path.splitext(file_path)[-1])


write_code_col('wedding_list.xlsx')
