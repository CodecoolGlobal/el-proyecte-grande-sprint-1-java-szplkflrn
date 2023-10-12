import { useNavigate } from "react-router-dom";
import "./login.css";

const Login = ({ onCancel }) => {
    const navigate = useNavigate();


    const extractUserRoleFromJWT = (token) => {
        const parts = token.split('.');
        
        if (parts.length !== 3) {
            throw new Error('Invalid JWT format');
        }
    
        const decodedPayload = JSON.parse(atob(parts[1]));
    
        return decodedPayload.role[0].authority;
    };

    const extractUserIDFromJWT = (token) => {
        const parts = token.split('.');
        
        if (parts.length !== 3) {
            throw new Error('Invalid JWT format');
        }
    
        const decodedPayload = JSON.parse(atob(parts[1]));
    
       
        return decodedPayload.publicID;
    };


    const loginUser = async (user) => {
        const res = await fetch("/api/users/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(user),
        });

        return await res.json();
    }

    const handleLoginUser = (user) => {
        loginUser(user)
            .then((response) => {
                    navigate("/");
                    localStorage.setItem("userrole", extractUserRoleFromJWT(response.token))
                    localStorage.setItem("userID", extractUserIDFromJWT(response.token))
                    localStorage.setItem("usertoken", response.token);
                    localStorage.setItem("username", user.email.split("@")[0]);
            })
            .catch((error) => {
                console.error("Error login user: ", error);
            })
    }

    const onSubmit = (e) => {
        e.preventDefault();
        const formData = new FormData(e.target);
        const entries = [...formData.entries()];

        const isAnyFieldEmpty = entries.some(([, v]) => !v);

        if (isAnyFieldEmpty) {
            alert("Please fill in all the fields");
            return;
        }

        const user = entries.reduce((acc, entry) => {
            const [k, v] = entry;
            acc[k] = v;
            return acc;
        }, {});
        handleLoginUser(user);
    };

    return (
        <section>
            <div className="form-box">
                <div className="form-value">
                    <form action="" onSubmit={onSubmit}>
                        <h2>Login</h2>

                        <div className="input-box">
                            <ion-icon name="mail-outline"></ion-icon>
                            <label htmlFor=""></label>
                            <input 
                            placeholder="Email"
                            type="email" 
                            name="email" 
                            id="email" />
                        </div>
                        <div className="input-box">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                            <label htmlFor=""></label>
                            <input 
                            placeholder="Password"
                            type="password" 
                            name="password" 
                            id="password" />
                        </div>
                        <div className="forget">
                            <label htmlFor=""><input type="checkbox" name="checkbox" id="checkbox" />Remember me</label>
                        </div>

                        <button id="login" type="submit">
                            Log in
                        </button>
                        <button type="button" onClick={onCancel}>
                            Cancel
                        </button>

                        <div className="register">
                            <p>Dont have an account <a href="games/register">Register</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    );
};

export default Login;