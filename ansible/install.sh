sudo apt-get update
sudo apt-get install software-properties-common --yes
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible --yes

ansible --version