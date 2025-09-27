# Vagrant quick start

1. Устанавливаете Vagrant: <https://www.vagrantup.com/downloads.html>  
2. Устанавливаете VirtualBox: <https://www.tecmint.com/install-virtualbox-on-redhat-centos-fedora> (пример для Linux)
3. Клонируете репозиторий со стендом и создаете виртуальную машину:
    ```bash
    git clone https://github.com/levelup-devops/2025-07-example.git 
    cd 2025-07-example/vagrant
    vagrant up  
    ```
4. Подключаетесь к виртуальной машине:
    ```bash
    vagrant ssh
    ```

Полезные ссылки:  
<https://www.vagrantup.com/intro/getting-started/>
<https://www.shellhacks.com/ru/vagrant-tutorial-for-beginners/>

## FAQs

1. Почему у меня внезапно выросло занимаемое место в виртуальной машине развернутой с помощью Vagrant?

    Скорее всего вы добавили дополнительное блочное устройство и оно лежит в одной директории
    с Vagrantfile. Vagrant в свою очередь при `Vagrant up` делает rsync всего, что есть рядом с
    Vagrantfile в директорию виртуальной машины `/vagrant/`

2. Как добавить дополнительные диски с помощью Vagrantfile

    ```ruby
    home = ENV['HOME'] # Используем глобальную переменную $HOME

    MACHINES = {
        :centos => {
            :disks => {
                :sata1 => {
                    :dfile => home + '/VirtualBox VMs/sata1.vdi', # Указываем где будут лежать файлы наших дисков
                    :size => 250, # Megabytes
                    :port => 1
                },
                :sata2 => {
                    :dfile => home + '/VirtualBox VMs/sata2.vdi',
                    :size => 250,
                    :port => 2
                },
                :sata3 => {
                    :dfile => home + '/VirtualBox VMs/sata3.vdi',
                    :size => 250,
                    :port => 3
                }
            }
        },
    }
    ```