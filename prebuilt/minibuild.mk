module_type = 'composite'
module_name = 'prebuilt'

composite_spec += [
  ['openssl.spec', {'file': True, 'spec_file': True, 'subdir': 'include'}],
  ['zlib.spec', {'file': True, 'spec_file': True, 'subdir': 'include'}],
  ['../openssl/build/crypto', {'subdir': 'libs'}],
  ['../openssl/build/ssl', {'subdir': 'libs'}],
  ['../zlib/shared', {'subdir': 'libs'}],
  ['../openssl/build/apps', {'subdir': 'bin'}],
]
