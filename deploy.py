#!/usr/bin/env python
import sys, requests, json, time, subprocess,os

#e.g. token = "cdae884ef42585ca35e797bc0a9730ff9c5f94f1c59f15f7c4fcb9722bd17261"
token = os.getenv('kerberosio_token')
if token == None:
    sys.exit("No token set, please add the token to your env 'kerberosio_token'.")

#e.g. server_name = "buildroot.cedricverstraeten.be"
server_name = os.getenv('kerberosio_server_name')
if server_name == None:
    sys.exit("No server-name set, please add the token to your env 'kerberosio_server_name'.")
    
#e.g. ssh_key = "a1:50:09:fd:19:27:61:27:93:aa:83:b0:c5:54:0c:37"
ssh_key = os.getenv('kerberosio_ssh_key')
if ssh_key == None:
    sys.exit("No ssh-key set, please add the token to your env 'kerberosio_ssh_key'.")
    
#e.g. image_id = "16641334"
image_id = os.getenv('kerberosio_image_id')
if image_id == None:
    sys.exit("No image set, please add the token to your env 'kerberosio_image_id'.")
    
#e.g. kios_dir = "/root/kios/"
kios_dir = os.getenv('kerberosio_kios_dir')
if kios_dir == None:
    sys.exit("No directory set, please add the token to your env 'kerberosio_kios_dir'.")
    
#e.g. release_dir = "/Users/cedricverst/app/releases/kerberosio/"
release_dir = os.getenv('kerberosio_release_dir')
if release_dir == None:
    sys.exit("No directory set, please add the token to your env 'kerberosio_release_dir'.")

authorization = {"Authorization":"Bearer " + token}
payload = {"name":server_name,"region":"nyc3","size":"2gb","image":image_id,"ssh_keys":[ssh_key],"backups":"false","ipv6":"false","user_data":"null","private_networking":"null"}

print "Creating droplet for Kerberos.io"
response = requests.post('https://api.digitalocean.com/v2/droplets', headers=authorization, json=payload)
result = json.loads(response.text)#
action = result["links"]["actions"][0]["href"]

# Wait until droplet has been created..
status = "in-progress"
while status == "in-progress":
    response = requests.get(action, headers=authorization)
    result = json.loads(response.text)
    status = result["action"]["status"]
    print "Waiting until droplet is created.."
    time.sleep(1)

# Droplet is created get it's IP-address
droplet_id = result["action"]["resource_id"]
response = requests.get("https://api.digitalocean.com/v2/droplets/" + `droplet_id`, headers=authorization)
droplet = json.loads(response.text)
ip_address = droplet["droplet"]["networks"]["v4"][0]["ip_address"]
print "Droplet created with ID:", droplet_id, "and IP-address:", ip_address
time.sleep(15)

# Removing existing releases
print "Removing existing releases"
subprocess.check_call(['ssh', 'root@'+ip_address, 'cd ' + kios_dir + ' && rm -rf releases/*'])

# Create new release
print "Creating releases"
subprocess.check_call(['ssh', 'root@'+ip_address, 'cd ' + kios_dir + ' && git pull && ./mkrelease.sh'])

# Copy release to local station
print "Transferring releases"
subprocess.check_call(["rsync", "-xav", "root@" + ip_address + ":'" + kios_dir + "releases/'", release_dir])

# Remove droplet again
response = requests.delete('https://api.digitalocean.com/v2/droplets/' + `droplet_id`, headers=authorization)
print "Removed droplet succesfully"