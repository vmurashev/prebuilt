from __future__ import print_function
import argparse
import os.path
import zipfile

DIR_HERE = os.path.normpath(os.path.abspath(os.path.dirname(__file__)))

def enumerate_directory_content(catalog, dname, prefix):
    subdirs = [(dname, prefix)]
    while subdirs:
        subdir_path, subdir_archname = subdirs[0]
        del subdirs[0]
        for item in sorted(os.listdir(subdir_path)):
            item_path = os.path.join(subdir_path, item)
            if subdir_archname:
                item_arcname = '/'.join([subdir_archname, item])
            else:
                item_arcname = item
            if os.path.isdir(item_path):
                subdirs.append((item_path, item_arcname))
            else:
                catalog.append((item_path, item_arcname))


def zip_pack(zipfilename, catalog):
    with zipfile.ZipFile(zipfilename, "w", zipfile.ZIP_DEFLATED) as z:
        for node in catalog:
            src, arcname = node[0], node[1]
            z.write(src, arcname)


def perform_pack(abi_list, directory_list, zipname):
    if not abi_list:
        print("ERRROR: ABI list is empty.")
        return 1
    if not directory_list:
        print("ERRROR: Directory list is empty.")
        return 1
    if len(abi_list) != len(directory_list):
        print("ERRROR: Sizes of ABIs and directories lists are different.")
        return 1
    if not zipname:
        print("ERRROR: Bad zip name.")
        return 1
    catalog = []
    headers_processed = False
    for idx in range(len(abi_list)):
        directory_to_scan = os.path.normpath(os.path.join(DIR_HERE, directory_list[idx]))
        print("Enumerating: {} ...".format(directory_to_scan))
        dir_headers = os.path.join(directory_to_scan, 'include')
        if not headers_processed:
            enumerate_directory_content(catalog, dir_headers, 'include')
            headers_processed = True
        dir_libs = os.path.join(directory_to_scan, 'libs')
        enumerate_directory_content(catalog, dir_libs, 'libs/'+ abi_list[idx])
        dir_bin = os.path.join(directory_to_scan, 'bin')
        enumerate_directory_content(catalog, dir_bin, 'bin/'+ abi_list[idx])

    zipfilename = os.path.normpath(os.path.join(DIR_HERE, zipname))
    zip_pack(zipfilename, catalog)
    print("Zip is here: {}".format(zipfilename))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--abi', nargs='*')
    parser.add_argument('--directory', nargs='*')
    parser.add_argument('--zipname', nargs='?')
    args = parser.parse_args()
    exit(perform_pack(args.abi, args.directory, args.zipname))


if __name__ == '__main__':
    main()
