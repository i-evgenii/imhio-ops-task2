my_usr=a-user
my_pwd=youdlehat6

for VM in privatenet-us-vm1 privatenet-us-vm2
do
   VMIP=gcloud compute instances describe $VM --format='get(networkInterfaces[0].accessConfigs[0].natIP)'
   echo "$VM ansible_host=$VMIP ansible_sudo_pass=$my_pwd ansible_become=true ansible_user=$my_usr ansible_password=$my_pwd\n" >> hosts
   gcloud compute ssh $VM
   sudo adduser $my_usr
   echo -e "$my_pwd\n$my_pwd" | sudo passwd $my_usr
   sudo usermod -aG wheel $my_usr
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
   sudo systemctl restart sshd
   exit
done

gcloud compute firewall-rules update publicnet-allow-ssh --source-ranges "0.0.0.0/0"
DBIP=gcloud compute instances describe privatenet-us-vm2 --format='get(networkInterfaces[1].networkIP)'
echo "ansible-playbook ./imhio-ops-task2.yml -i hosts --extra-vars \"dbip=$DBIP dbrootpwd=mysql-root-password dbusrpwd=mysql-tcg-password\""
gcloud compute firewall-rules update publicnet-allow-ssh --source-ranges "35.235.240.0/20,109.163.216.0/21"
