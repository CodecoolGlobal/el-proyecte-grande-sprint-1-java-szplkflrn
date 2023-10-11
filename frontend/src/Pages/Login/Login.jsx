import { useNavigate } from "react-router-dom";
import "./login.css";

const Login = ({ onCancel }) => {

    const navigate = useNavigate();

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
                    localStorage.setItem("usertoken", response.token);
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

        //user.reviews = [];
        console.log(user);
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
                            <label htmlFor=""><input type="checkbox" name="checkbox" id="checkbox" />Remember me <a href="/forgetpassword">Forget Password</a></label>
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