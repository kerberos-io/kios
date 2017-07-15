from os import walk
import requests
from requests.auth import HTTPBasicAuth

path = "./releases"
releaseID = ""
token = ""

# Get list of assets from dev branch

r = requests.get('https://api.github.com/repos/cedricve/kios/releases/%s/assets' % releaseID)
releases = r.json()

for release in releases:
    headers = {
        'content-type': 'application/json',
        'Authorization': 'token %s' % token
    }
    url = "https://api.github.com/repos/cedricve/kios/releases/assets/%s" % str(release['id'])
    response = requests.delete(url, headers=headers)
    print response

# Get last release

dates = []
for (dirpath, dirnames, filenames) in walk(path):
    dirParts = dirpath.split('/')
    if len(dirParts) > 3 :
        if dirParts[3] not in dates:
            dates.append(dirParts[3])

dates.sort(key=int)
lastRelease = dates[-1]

# Get files from last release and take only the web.tar.gz
# from the rpi3 release (no need to upload the different ones).

filesToUpload = []
for (dirpath, dirnames, filenames) in walk(path):
    for filename in filenames:
        fullPath = dirpath + "/" + filename
        pathParts = fullPath.split("/")
        if len(pathParts) > 4 and pathParts[3] == lastRelease:
            if (pathParts[2] != "rpi3" and pathParts[4] == "web.tar.gz") or pathParts[4] == ".DS_Store" :
                continue
            else:
                filesToUpload.append(fullPath)

print filesToUpload

# Upload assets (files) to develop release
# POST https://<upload_url>/repos/:owner/:repo/releases/:id/assets?name=foo.zip

for file in filesToUpload:
    headers = {
        'content-type': 'application/octet-stream',
        'Authorization': 'token %s' % token
    }
    pathParts = file.split("/")
    url = "https://uploads.github.com/repos/cedricve/kios/releases/%s/assets?name=%s" % (releaseID, pathParts[4])
    response = requests.post(url, data=open(file,'rb'), headers=headers)
    print response
