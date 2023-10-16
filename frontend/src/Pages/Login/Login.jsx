import { useNavigate } from "react-router-dom";
import "./login.css";

const Login = ({ onCancel }) => {
    const navigate = useNavigate();


    const extractUser = (token) => {
        const parts = token.split('.');
        
        if (parts.length !== 3) {
            throw new Error('Invalid JWT format');
        }
    
        const decodedPayload = JSON.parse(atob(parts[1]));

        let appUser = {};
        appUser.name = decodedPayload.user_name;
        appUser.publicID = decodedPayload.name;
        appUser.authority = decodedPayload.role[0].authority;

        return appUser;
    }


    const loginUser = async (user) => {

        const res = await fetch("/api/users/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(user),
        });

        if (res.ok) {
            return await res.json();     
        } 
        else {
            window.alert("Bad username/password")
        }
    }

    const handleLoginUser = (user) => {
            loginUser(user)
            .then((response) => {
                    navigate("/");
                    localStorage.setItem("userrole", extractUser(response.token).authority)
                    localStorage.setItem("userID", extractUser(response.token).publicID)
                    localStorage.setItem("usertoken", response.token);
                    localStorage.setItem("username", extractUser(response.token).name);
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
                        <br></br>
                        <br></br>
                        <button id="login" type="button" onClick={onCancel}>
                            Cancel
                        </button>

                        <div className="register">
                            <p>Do not have an account <a href="games/register">Register</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    );
};

export default Login;