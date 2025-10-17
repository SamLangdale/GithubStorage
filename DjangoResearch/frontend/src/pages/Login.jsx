import { Link } from "react-router-dom"
import Form from "../components/Form"

function Login() {
    return(
        <>
     <Form route="/api/token/" method="login" />
      <div className="register">
          <Link to="/register"><button>Register</button></Link>
      </div>
     </>

    )
}

export default Login