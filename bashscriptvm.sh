vagrantAnsibleP(){
cd /home/student/VM2/Klanten/"$_klantnaam"
vagrant up
ansible-playbook hosts.yml
}

vagrantAnsibleT(){
cd /home/student/VM2/Klanten/"$_klantnaam"/testomgeving
vagrant up
ansible-playbook hosts.yml
}

counter(){
TEMPFILE=/home/student/VM2/benodigdheden/counter
COUNTER=$[$(cat $TEMPFILE) + 1]
echo $COUNTER > $TEMPFILE	
}

files(){
sed -i "s+klantnaam+$_klantnaam+g" Vagrantfile
sed -i "s+aantalWeb+$_aantalWeb+g" Vagrantfile
sed -i "s+ram+$_ram+g" Vagrantfile
sed -i "s+klantid+$COUNTER+g" Vagrantfile
sed -i "s+klantid+$COUNTER+g" inventory.ini
}

verwijderRoles(){
rm -r roles
rm hosts.yml	
}

cprolesP(){
		cp -r /home/student/VM2/playbooks/roles/ /home/student/VM2/Klanten/"$_klantnaam"/roles/
		cp -r /home/student/VM2/playbooks/hosts.yml /home/student/VM2/Klanten/"$_klantnaam"/hosts.yml
}

cprolesT(){
			cp -r /home/student/VM2/playbooks/roles/ /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/roles/
		cp -r /home/student/VM2/playbooks/hosts_T.yml /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/hosts.yml
	}
#omgeving uitrollen
omgevingAanmaken(){

cd /home/student/VM2/Klanten
mkdir -p "$_klantnaam"
cd "$_klantnaam"

counter

while true; do
	read -p "Wenst u een productie (p) of een test omgeving (t)? " _TypeOmgeving
	read -p "Hoeveel Webservers wenst u te hebben? " _aantalWeb
	read -p "Hoeveel RAM wenst u te hebben bij al uw servers? " _ram

	if [ "$_TypeOmgeving" = "p" ];
	then
		echo "U Wenst een productieomgeving"
		cp /home/student/VM2/benodigdheden/Vagrantfile /home/student/VM2/Klanten/"$_klantnaam"/Vagrantfile
		cp /home/student/VM2/benodigdheden/inventory.ini /home/student/VM2/Klanten/"$_klantnaam"/inventory.ini 
		cp /home/student/VM2/benodigdheden/ansible.cfg /home/student/VM2/Klanten/"$_klantnaam"/ansible.cfg
		cprolesP
		sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/roles/php/templates/index.php.j2
		sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/roles/lb/defaults/main.yml
		sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/roles/db/tasks/config.yml	
		files
		vagrantAnsibleP
		verwijderRoles
	elif [ "$_TypeOmgeving" = "t" ];
	then
		echo "u wenst een test omgeving"
		mkdir -p "testomgeving"
		cp /home/student/VM2/benodigdheden/Vagrantfile_T /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/Vagrantfile
		cp /home/student/VM2/benodigdheden/inventory_T.ini /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/inventory.ini 
		cp /home/student/VM2/benodigdheden/ansible.cfg /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/ansible.cfg
		cprolesT
		sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/roles/php/templates/index.php.j2
		sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/roles/lb/defaults/main.yml
		sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/testomgeving/roles/db/tasks/config.yml
		cd "testomgeving"
		files
		vagrantAnsibleT
		verwijderRoles
	else
		echo "foutieve invoer, vul p of t in"
		continue
	fi
	break
done
}

omgevingAanpassen(){
cd /home/student/VM2/Klanten/"$_klantnaam"

ramProductie(){
read -p "Hoeveel RAM wenst u te hebben bij al uw servers? " _ramAP
sed -i "s+512+$_ramAP+g" Vagrantfile
sed -i "s+1024+$_ramAP+g" Vagrantfile
sed -i "s+2048+$_ramAP+g" Vagrantfile
vagrant reload
}

aantalWebProdcutie(){
read -p "Hoeveel Webservers wenst u te hebben? " _aantalWebAP
sed -i "s+aantalWeb+$_aantalWebAP+g" Vagrantfile
vagrant reload
}

ramTest(){
cd "testomgeving"
read -p "Hoeveel RAM wenst u te hebben bij al uw servers? " _ramAT
sed -i "s+512+$_ramAT+g" Vagrantfile
sed -i "s+1024+$_ramAT+g" Vagrantfile
sed -i "s+2048+$_ramAT+g" Vagrantfile
vagrant reload
}

aantalWebProdcutie(){
cd "testomgeving"
read -p "Hoeveel Webservers wenst u te hebben? " _aantalWebAT
sed -i "s+aantalWeb+$_aantalWebAT+g" Vagrantfile
vagrant reload
}


extraProductie(){
read -p "Hoeveel Webservers wenst u te hebben? " _aantalWeb
read -p "Hoeveel RAM wenst u te hebben bij al uw servers? " _ram
counter
mkdir -p "productieomgeving2"
echo "U krijgt een extra productie omgeving"
cp /home/student/VM2/benodigdheden/Vagrantfile /home/student/VM2/Klanten/"$_klantnaam"/productie2/Vagrantfile
cp /home/student/VM2/benodigdheden/inventory.ini /home/student/VM2/Klanten/"$_klantnaam"/productie2/inventory.ini 
cp /home/student/VM2/benodigdheden/ansible.cfg /home/student/VM2/Klanten/"$_klantnaam"/productie2/ansible.cfg
cp -r /home/student/VM2/playbooks/roles/ /home/student/VM2/Klanten/"$_klantnaam"/productie2/roles/
cp -r /home/student/VM2/playbooks/hosts.yml /home/student/VM2/Klanten/"$_klantnaam"/productie2/hosts.yml
sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/productie2/roles/php/templates/index.php.j2
sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/productie2/roles/lb/defaults/main.yml
sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/productie2/roles/db/tasks/config.yml	
cd "productieomgeving2"	
sed -i "s+01+02+g" Vagrantfile
files
vagrantAnsibleP
verwijderRoles
}

extraTest(){
read -p "Hoeveel Webservers wenst u te hebben? " _aantalWeb
read -p "Hoeveel RAM wenst u te hebben bij al uw servers? " _ram
counter
mkdir -p "testomgeving2"
cd "testomgeving2"
cp /home/student/VM2/benodigdheden/Vagrantfile_T /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/Vagrantfile
cp /home/student/VM2/benodigdheden/inventory_T.ini /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/inventory.ini 
cp /home/student/VM2/benodigdheden/ansible.cfg /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/ansible.cfg
cp -r /home/student/VM2/playbooks/roles/ /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/roles/
cp -r /home/student/VM2/playbooks/hosts_T.yml /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/hosts.yml
sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/roles/php/templates/index.php.j2
sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/roles/lb/defaults/main.yml
sed -i "s+klantid+$COUNTER+g" /home/student/VM2/Klanten/"$_klantnaam"/testomgeving2/roles/db/tasks/config.yml
echo "U krijgt een extra test omgeving"	

sed -i "s+01+02+g" Vagrantfile
files
vagrant up
ansible-playbook hosts.yml
verwijderRoles
}


printf "Wat wilt u doen?\n"
printf "1: RAM aanpassen van de productie omgeving\n"
printf "2: aantal webservers aanpassen van de productie omgeving\n"
printf "3: RAM aanpassen van de test omgeving\n"
printf "4: aantal webservers aanpassen van de test omgeving\n"
printf "5: nog een productie omgeving uitrollen\n"
printf "6: nog een test omgeving uitrollen\n"
read -p "vul uw optie in: " _optieAanpassen

while true; do
	if [ "$_optieAanpassen" = 1 ];
	then
		ramProductie
	elif [ "$_optieAanpassen" = 2 ]; then
		aantalWebProdcutie
	elif [ "$_optieAanpassen" = 3 ]; then
		ramTest
	elif [ "$_optieAanpassen" = 4 ]; then
		aantalWebTest
	elif [ "$_optieAanpassen" = 5 ]; then
		extraProductie
	elif [ "$_optieAanpassen" = 6 ]; then
		extraTest				
	else
		echo "verkeerde optie"
		continue
	fi
	break
done
}

omgevingVerwijderen(){
echo "omgevingVerwijderen"
cd /home/student/VM2/Klanten/"$_klantnaam"


while true; do
	read -p "Wenst u een productie (p) of een test omgeving (t) te verwijderen? " _TypeOmgeving

	if [ "$_TypeOmgeving" = "p" ];
	then
		echo "U Wenst een productieomgeving te verwijderen"
		vagrant destroy -f
		rm Vagrantfile
		rm inventory.ini
		rm ansible.cfg

	elif [ "$_TypeOmgeving" = "t" ];
	then
		echo "u wenst een test omgeving te verwijderen"
		cd "testomgeving"
		vagrant destroy -f
		rm Vagrantfile
		rm inventory.ini
		rm ansible.cfg
	else
		echo "foutieve invoer, vul p of t in"
		continue
	fi
	break
done
}

printf "Welkom"
printf "\n"

read -p "Wat is uw klantnaam? " _klantnaam
read -p "wachtwoord: " 
echo "Welkom: $_klantnaam"

printf "Wat wilt u doen?\n"
printf "1: omgeving aanvragen\n"
printf "2: omgeving aanpassen\n"
printf "3: omgeving verwijderen\n"
read -p "vul uw optie in: " _optie
while true; do
	if [ "$_optie" = 1 ];
	then
		omgevingAanmaken
	elif [ "$_optie" = 2 ]; then
		omgevingAanpassen
	elif [ "$_optie" = 3 ]; then
		omgevingVerwijderen
	else
		echo "verkeerde optie"
		continue
	fi
	break
done