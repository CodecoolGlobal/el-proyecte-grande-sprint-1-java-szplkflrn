const Register = ({ onSave, onCancel }) => {
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
    user.favoriteBoardGamePublicIDS = "";
    user.reviews = [];
    console.log(user);
    onSave(user);
  };
  return (
    <section>
      <div className="form-box">
        <div className="form-value">
          <form action="" onSubmit={onSubmit}>
            <h2>Register</h2>

            <div className="input-box">
              <ion-icon name="user_name-outline"></ion-icon>
              <label htmlFor="name"></label>
              <input placeholder="Username" name="name" id="name" />
            </div>

            <div className="input-box">
              <ion-icon name="email-outline"></ion-icon>
              <label htmlFor="email"></label>
              <input placeholder="E-mail" name="email" id="email" />
            </div>

            <div className="input-box">
              <ion-icon name="lock-closed-outline"></ion-icon>
              <label htmlFor="password"></label>
              <input
                type="password"
                placeholder="Password"
                name="password"
                id="password"
              />
            </div>

            <button type="submit">Register</button>
            <button type="button" onClick={onCancel}>
              Cancel
            </button>
          </form>
        </div>
      </div>
    </section>
  );
};

export default Register;