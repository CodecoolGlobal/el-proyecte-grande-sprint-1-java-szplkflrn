
const Register = () => {

    return (
        <section>
            <div className="form-box">
                <div className="form-value">
                    <form action="">
                        <h2>Register</h2>
                        <div className="input-box">
                            <ion-icon name="mail-outline"></ion-icon>
                            <input type="email" name="email" id="email" />
                            <label htmlFor="">E-mail</label>
                        </div>
                        <div className="input-box">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                            <input type="password" name="password" id="password" />
                            <label htmlFor="">Password</label>
                        </div>
                        <button id="login">Register</button>
                        <div className="register">
                        </div>
                    </form>
                </div>
            </div>
        </section>
    )
}

export default Register;