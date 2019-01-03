import re
import socket
import sys
import random
import requests
import codecs
import json
import time

#TODO:
#!ctf - решение цтфного таска/сервиса

lastGuessTime = -1
rule = "a+b=c"
HOST = "irc.twitch.tv"
PORT = 6667
CHAN = "#rprtr258"
NICK = "rprtr258"
PASS = ""
with open('PASS.txt', 'r') as myfile:
    PASS = myfile.read()
VK_TOKEN = ""
with open('VK_TOKEN.txt', 'r') as myfile:
    VK_TOKEN = myfile.read()

def send_pong(msg):
    con.send(bytes('PONG %s\r\n' % msg, 'UTF-8'))

def send_message(msg):
    con.send(bytes('PRIVMSG %s :%s\r\n' % (CHAN, msg), 'UTF-8'))
    #print(NICK + ": " + msg)
    #sys.stdout.flush()

def send_nick(nick):
    con.send(bytes('NICK {}\r\n'.format(nick).encode("utf-8")))

def send_pass(password):
    con.send(bytes('PASS %s\r\n' % password, 'UTF-8'))

def join_channel(chan):
    con.send(bytes('JOIN %s\r\n' % chan, 'UTF-8'))

def part_channel(chan):
    con.send(bytes('PART %s\r\n' % chan, 'UTF-8'))

def get_sender(msg):
    result = ""
    for char in msg:
        if char == "!":
            break
        if char != ":":
            result += char
    return result

def get_message(msg):
    result = ""
    i = 3
    length = len(msg)
    while i < length:
        result += msg[i] + " "
        i += 1
    result = result.lstrip(':')
    return result

def parse_message(msg):
    if len(msg) >= 1:
        print(msg)
        sys.stdout.flush()
        msg = msg.split(' ')
        options = {'!status': command_status,
                   '!help': command_help,
                   '!246': command_246,
                   '!ctf': command_ctf}
        if msg[0] in options:
            options[msg[0]](msg[1:-1])
def command_246(args):
    global lastGuessTime
    curTime = int(round(time.time() * 1000))
    commands = ["try", "guess", "rules"]
    if len(args) < 1 or not args[0] in commands:
        help_246()
    elif args[0] == "rules":
        send_message("/me Загадано условие на тройку чисел, можно спросить, подходит ли тройка под это условие(!246 try) либо угадать правило(!246 guess) раз в час")
    elif args[0] == "guess":
        if len(args) != 2:
            help_246()
        elif curTime - lastGuessTime < 3600000:
            send_message("/me Осталось {} секунд до следющей попытки".format(3600 - (curTime - lastGuessTime) // 1000))
        else:
            lastGuessTime = curTime
            if args[1] == rule:
                send_message("/me Правильно! Получите модерку.")
            else:
                send_message("/me Нет, это неправильно(наверное)")
    elif args[0] == "try":
        print(args)
        if len(args) != 4:
            help_246()
        else:
            a, b, c = map(int, args[1:])
            if a + b == c:
                send_message("/me Тройка подходит")
            else:
                send_message("/me Тройка не подходит")
        
def help_246():
    send_message("/me Usage: ")
    send_message("/me !246 rules - правила")
    send_message("/me !246 try 3 4 5 - спросить тройку 3 4 5")
    send_message("/me !246 guess - попробовать угадать правило вида a*a+b*b=c*c")

def command_status(args):
    found = False
    while not found:
        vkId = random.randrange(1, 10000000)
        source = requests.get("https://api.vk.com/method/users.get?user_ids={}&fields=status&version=5.92&access_token={}".format(vkId, VK_TOKEN)).content
        source = codecs.decode(source, "utf-8")
        resp = json.loads(source)['response'][0]
        if 'status' in resp:
            status = resp['status']
            if status != "":
                found = True
                send_message(status)

def command_help(args):
    send_message('!help - this message')
    send_message('!status - random quote')
    send_message('!246 - 2-4-6 game, !246 rules for details')
    send_message('!ctf - some ctf service or task')

def command_ctf(args):
    send_message('ctf triggered')

con = socket.socket()
con.connect((HOST, PORT))

send_pass(PASS)
send_nick(NICK)
join_channel(CHAN)

data = ""

while True:
    try:
        data = data + con.recv(1024).decode('UTF-8')
        data_split = re.split(r"[~\r\n]+", data)
        data = data_split.pop()

        for line in data_split:
            line = str.rstrip(line)
            line = str.split(line)

            if len(line) >= 1:
                if line[0] == 'PING':
                    send_pong(line[1])

                if line[1] == 'PRIVMSG':
                    sender = get_sender(line[0])
                    message = get_message(line)
                    parse_message(message)
                    sys.stdout.flush()

    except socket.error:
        print("Socket died")
    except socket.timeout:
        print("Socket timeout")
