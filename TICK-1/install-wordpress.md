### How to install WordPress on Ubuntu 22.04 with LEMP
Here is the detailed manual on how to install WordPress on Ubuntu 22.04 with LEMP:

### Step 1: Update the Operating System
Before you start installing WordPress, it is important to make sure that your Ubuntu 22.04 operating system is up to date. Open the terminal and run the following commands:
````
sudo apt-get update
sudo apt-get upgrade
````
### Step 2: Install Nginx
Nginx is a web server that will be used to host the WordPress website. Run the following command to install Nginx:
````
sudo apt-get install nginx
````
Once the installation is complete, start the Nginx service with the following command:

sudo systemctl start nginx
### Step 3: Install MySQL
MySQL is a database management system that will be used to store the data for the WordPress website. Run the following command to install MySQL:
````
sudo apt-get install mysql-server
````
During installation, you will be prompted to set a password for the MySQL root user.

Once the installation is complete, start the MySQL service with the following command:
````
sudo systemctl start mysql
````
### Step 4: Install PHP
PHP is a programming language used to execute code on the web server. Run the following command to install PHP and the necessary modules:
````
sudo apt-get install php-fpm php-mysql
````

### Step 5: Configure Nginx
Now that the necessary components have been installed, it is time to configure Nginx to host the WordPress website. Open the default Nginx configuration file with the following command:
````
sudo nano /etc/nginx/sites-available/default
````
Inside the file, find the section starting with server { and replace its contents with the following:
````
server {
    listen 80;
    listen [::]:80;
    root /var/www/html;
    index index.php index.html index.htm;
    server_name example.com www.example.com;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
````
Remember to replace example.com and www.example.com with the domain name of your website.

Save and close the configuration file.

Check and reload the new nginx configuration:
````
nginx -t
/etc/init.d/nginx reload
````
### Step 6: Create the WordPress database
Create a MySQL database for WordPress with the following command:
````
mysql -u root -p
````
You will be prompted to enter the MySQL root user password. Once you are in the MySQL console, execute the following commands:
````
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
exit;
````
Remember to replace password with a strong password.

### Step 7: Download and install WordPress
Download the latest version of WordPress with the following command:
````
cd /tmp
wget https://wordpress.org/latest.tar.gz
````
Unzip the downloaded file with the following command:
````
tar -zxvf latest.tar.gz
````
Copy the unzipped WordPress files to the root directory of the web server with the following command:
````
sudo cp -r /tmp/wordpress/* /var/www/html
````
Change the ownership of the root directory to the user www-data with the following command:
````
sudo chown -R www-data:www-data /var/www/html
````
### Step 8: Configure WordPress
Open your browser and access the website.

Follow the WordPress installation, selecting first the language and, in the next tab, the data concerning the database. The database name, username, password and server.

During the manual we have used the following data:
````
Database name: wordpress
User: wordpressuser
Password: password
````
As the server, you will need to enter "localhost".

Complete the WordPress configuration details and follow the instructions to set up your website.
