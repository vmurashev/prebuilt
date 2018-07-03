module_type = 'composite'
module_name = 'prebuilt'

composite_spec += [
  ['openssl.spec', {'file': True, 'spec_file': True, 'subdir': 'include'}],
  ['zlib.spec', {'file': True, 'spec_file': True, 'subdir': 'include'}],
  ['../openssl/build/crypto', {'subdir': 'libs/macosx/x86_64'}],
  ['../openssl/build/ssl', {'subdir': 'libs/macosx/x86_64'}],
  ['../zlib/shared', {'subdir': 'libs/macosx/x86_64'}],
]
