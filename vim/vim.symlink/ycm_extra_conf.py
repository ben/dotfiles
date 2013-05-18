import os
import re
import ycm_core
import vimsupport

def DirectoryOfThisScript():
	return os.path.dirname( os.path.abspath( __file__ ) )

def AbsPathToLibgit2(relpath):
	return os.path.join('/Users/ben/src/libgit2/', relpath)

libgit2_flags = [
		'-D_GNU_SOURCE',
		'-DOPENSSL_SHA1',
		'-DNO_VIZ',
		'-DSTDC',
		'-DNO_GZIP',
		'-DGIT_SSL',
		'-D_FILE_OFFSET_BITS=64',
		'-DCLAR_FIXTURE_PATH="' + AbsPathToLibgit2('tests-clar/resources/') + '"',
		'-DCLAR_RESOURCES=""',
		'-Wall',
		'-Wextra',
		'-Wno-missing-field-initializers',
		'-Wstrict-aliasing=2',
		'-Wstrict-prototypes',
		'-I/opt/github/homebrew/include',
		'-fvisibility=hidden',
		'-fPIC',
		'-Wno-deprecated-declarations',
		'-g'
		'-I', AbsPathToLibgit2('src'),
		'-I', AbsPathToLibgit2('include'),
		'-I', AbsPathToLibgit2('deps/http-parser'),
		'-I', AbsPathToLibgit2('deps/zlib'),
		'-I', AbsPathToLibgit2('tests-clar'),
		'-std=c89',
		'-x', 'c',
		]


def FlagsForFile( filename ):
	if re.search('libgit2', filename):
		return {
				'flags': libgit2_flags,
				'do_cache': False,
				}
	return {
			'flags': [],
			'do_cache': True,
			}
