![Project Logo](https://raw.githubusercontent.com/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn/development/frontend/src/assets/wallpaper/Byte_Battlers.png)

![GitHub repo size](https://img.shields.io/github/repo-size/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn)
![GitHub language count](https://img.shields.io/github/languages/count/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn)
![Static Badge](https://img.shields.io/badge/total%20number%20of%20tracked%20files-90-blue)
![GitHub contributors](https://img.shields.io/github/contributors/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/t/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn?label=total%20commits)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn?label=monthly%20commits)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn/development)
![GitHub closed issues](https://img.shields.io/github/issues-closed/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn)
![GitHub issues](https://img.shields.io/github/issues-raw/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn)
![GitHub pull requests](https://img.shields.io/github/issues-pr/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn)




# ByteBattlers
**A full stack CRUD web application with the following technologies:**
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/frameworks/react.svg" alt="drawing" width="30" align="center"/> *React* 
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/programming%20languages/javascript.svg" alt="drawing" width="30" align="center"/> *JavaScript*
-  <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/frameworks/spring.svg" alt="drawing" width="30" align="center"/> *Spring*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/programming%20languages/java.svg" alt="drawing" width="30" align="center"/> *Java* 
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/databases/postgresql.svg" alt="drawing" width="30" align="center"/> *PostgreSQL*

# Background
**A BoardgameGeek inspired web application where users can:**
- *Search for board games*
- *Register themselves securely*
- *Add a board game to their virtual collection*
- *Rate/review any chosen board game*

# Prerequisites
- <img src="https://upload.wikimedia.org/wikipedia/commons/5/52/Apache_Maven_logo.svg" alt="drawing" width="30" align="center"/> *Maven 3.6.3*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/frameworks/nodejs.svg" alt="drawing" width="30" align="center"/> *Node 19.8.1*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/programming%20languages/java.svg" alt="drawing" width="30" align="center"/> *Java 17.0.7*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/others/npm.svg" alt="drawing" width="30" align="center"/> *NPM 9.5.1*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/databases/postgresql.svg" alt="drawing" width="30" align="center"/> *PostgreSQL 12.16*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/others/git.svg" alt="drawing" width="30" align="center"/> *Git 2.30.2*

# Usage

**Clone with the following command line:**

```bash
# Clone this repository
git clone https://github.com/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn.git

```

## Frontend 

```bash
# Go to your local folder
cd {local_folder_of_cloned_project/frontend}

# Install dependencies
npm i

# Run application
npm run dev

# Visit localhost:5173

```

## Backend

### Option 1: Without an IDE

- **Create a database for testing the application**
- **Navigate to {local_folder_of_cloned_project/backend/src/resources/db/migration}**
- **Open "init-schema.sql" and copy the query**
- **Open the created test database with a query tool and run the copied query to initialzie the database**
- **Run the following command lines**

```bash
# Navigate to the local folder
cd {local_folder_of_cloned_project/backend}

# Build the project to a jar file
mvn clean install

# Run the applicaiton
java -jar -Dspring.datasource.url=jdbc:postgresql://localhost:5432/${database} -Dlogging.file.path=${log_folder_path} -Dspring.datasource.password=${password} -Dapplication.secret=${secret_key} -Dapplication.username=${username} bytebattlers-0.0.1-SNAPSHOT.jar
```

### Option 2: With an IDE

- **Create a database for testing the application**
- **Navigate to {local_folder_of_cloned_project/backend/src/resources/db/migration}**
- **Open "init-schema.sql" and copy the query**
- **Open the created test database with a query tool and run the copied query to initialzie the database**
- **Change the required local enviromental variables values to your system settings (e.g. "DATABASE", "PASSWORD", etc)**
- **Run the ByteBattlersApplication**


##  Running with Docker

- Create a .env file in the ${local_folder_of_cloned_project}
- Fill out the followings and copy them into the .env file
```env

SQL_SERVER=${your sql url}
SQL_PORT=${your sql port}
DATABASE=${your database name}
USERNAME=${your username}
PASSWORD=${your password}
LOG_FOLDER=${your log folder path}
SECRET_KEY=${your secret key}
```

```bash
# Backend
# Navigate to the local folder
cd {local_folder_of_cloned_project/backend}

# Build the project to a jar file
mvn clean install

# Copy the bytebattlers-0.0.1-SNAPSHOT.jar from the target folder to the backend folder
cp ./target/bytebattlers-0.0.1-SNAPSHOT.jar ./../

# And run the following:
sudo docker build -t my-java .

# Frontend
# Navigate to the local folder
cd {local_folder_of_cloned_project/frontend}

# Run the following:
sudo docker build -t my-frontend .

# Change back to the main project folder
cd ..

# Running in Docker
sudo docker-compose up -d

# Both frontend and backend should run on the 5173 and 8080 ports
```


# See also
[Checkout our WIKI page](https://github.com/CodecoolGlobal/el-proyecte-grande-sprint-1-java-szplkflrn/wiki)

# License
