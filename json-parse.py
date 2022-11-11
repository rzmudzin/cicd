import sys
import os
import json

# print("\Parsing build file ", sys.argv[1])

#dataStr = '{"commit":"Test123","GIT_REPO_URL":"git://github.com/rzmudzin/guesstheflag_uikit.git","GIT_REF_BRANCH":"main","GIT_REF":"refs/heads/main","GIT_BASE_REF":"","GIT_HEAD_REF":""}'
#data = json.loads(dataStr)

with open(sys.argv[1], 'r') as f:
  data = json.load(f)

for index, (key, value) in enumerate(data.items()):
    print("\"{}\" \"{}\"".format(key, value), end='\n')

sys.exit(0)
