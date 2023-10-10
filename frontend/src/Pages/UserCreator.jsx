import { useEffect, useState } from "react";
import Register from "./Register/Register";
import { useNavigate } from "react-router-dom";

const UserCreator = () => {

    const [users, setUsers] = useState([]);
    const navigate = useNavigate();


    const createUser = async (user) => {
        const res = await fetch("/api/users/register", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(user),
        });

        return await res.text();
    }


    const userFetch = async () => {
        try {
            const response = await fetch("/api/users");
            const data = await response.json();
            setUsers(data);
        } catch (error) {
            console.log(error);
        }
    }

    useEffect(() => {
        userFetch();
    }, []);

    const handleCreateUser = (user) => {
        let userExists = false;
        for (let i = 0; i < users.length; i++) {
            if (user.name === users[i].name) {
                userExists = true;
                break;
            }
        }

        if (userExists) {
            alert("This user is already registered!");
        } else {
            createUser(user)
                .then(() => {
                    navigate("/");
                })
                .catch((error) => {
                    console.error("Error creating user: ", error);
                })
        }
    };

    return (
        <Register
        onCancel={() => navigate("/")}
        onSave={handleCreateUser}
        />
    );
}

export default UserCreator;