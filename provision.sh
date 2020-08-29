#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update -y
sleep 10
sudo apt install -y curl vim jq git make apt-transport-https helm
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
sudo curl -sL get.docker.com | sh
sudo usermod -aG docker ubuntu
sudo docker pull rancher/k3s:v1.18.6-k3s1
sudo docker pull rancher/k3d-proxy:v3.0.1
sudo docker pull alpine
sudo docker pull ubuntu
sudo docker pull nginx:alpine
sudo docker pull bryandollery/terraform-packer-aws-alpine
sudo docker pull jenkinsci/blueocean
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
curl -LOs https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod a+rx kubectl
sudo mv kubectl /usr/local/bin
git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugins/start/vim-terraform
git clone https://github.com/hashivim/vim-packer.git ~/.vim/pack/plugins/start/vim-packer
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/plugins/start/fugitive
git clone https://github.com/martinda/Jenkinsfile-vim-syntax.git ~/.vim/pack/plugins/start/jenkinsfile
curl -sfL https://get.k3s.io | sh -
sudo systemctl enable k3s
sudo systemctl start k3s
sleep 5
sudo cat /var/lib/rancher/k3s/server/token
sudo cp /var/lib/rancher/k3s/server/token /home/ubuntu/token
sudo chmod a+rw /home/ubuntu/token
sudo chown ubuntu:ubuntu /home/ubuntu/token
sudo chmod a+r /etc/rancher/k3s/k3s.yaml
kubectl taint node $(hostname) k3s-controlplane=true:NoSchedule
sudo apt autoremove -y
echo "source /home/ubuntu/.bash_aliases"
echo 'alias k=kubectl' > /home/ubuntu/.bash_aliases
echo "alias ll='ls -gAlFh'"
cat <<EOF >> /home/ubuntu/.vimrc
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
EOF

echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list


echo "done"
