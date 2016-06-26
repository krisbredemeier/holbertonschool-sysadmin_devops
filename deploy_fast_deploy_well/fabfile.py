from fabric.api import *

env.hosts = ['158.69.91.82']
env.user = "admin"

def commit():
    local("git add -p && git commit")

def push():
    local("git push")

def pack():
    commit()
    push()

def deploy():
    code_dir = '/var/www/html/impossible/index.html'
    with cd(code_dir):
        run("git pull")
