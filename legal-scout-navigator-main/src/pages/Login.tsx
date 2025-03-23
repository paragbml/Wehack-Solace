
import { useNavigate } from "react-router-dom";
import { toast } from "sonner";
import AuthForm from "@/components/AuthForm";
import Navbar from "@/components/Navbar";
import { ArrowRight } from "lucide-react";

const Login = () => {
  const navigate = useNavigate();

  const handleLogin = (data: any) => {
    console.log("Login attempt with:", data);
    
    // Simulate a successful login (you'd connect to your auth service here)
    setTimeout(() => {
      // For demo purposes - using hardcoded credentials
      if (data.email === "demo@example.com" && data.password === "password") {
        // Success
        toast.success("Login successful!");
        navigate("/dashboard");
      } else {
        // Failure
        toast.error("Invalid credentials. Try demo@example.com / password");
      }
    }, 1000);
  };

  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-br from-gray-50 to-gray-100">
      <Navbar />
      
      <div className="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div className="w-full max-w-md space-y-8">
          <div className="text-center">
            <h1 className="text-3xl font-bold tracking-tight text-primary">Welcome to LegalAware</h1>
            <p className="mt-2 text-sm text-muted-foreground">
              Your comprehensive legal resource platform
            </p>
          </div>
          
          <div className="bg-white p-8 rounded-xl shadow-sm border border-gray-100 animate-fade-in">
            <div className="bg-primary/5 rounded-lg p-4 mb-6">
              <p className="text-sm font-medium text-primary">
                Demo Credentials
              </p>
              <div className="mt-2 text-sm text-muted-foreground space-y-1">
                <p>Email: <span className="font-medium">demo@example.com</span></p>
                <p>Password: <span className="font-medium">password</span></p>
              </div>
            </div>
            
            <AuthForm
              type="login"
              onSubmit={handleLogin}
            />
            
            <div className="mt-6 text-center">
              <button 
                onClick={() => navigate('/dashboard')} 
                className="inline-flex items-center text-sm text-primary font-medium hover:underline"
              >
                Continue as guest
                <ArrowRight className="ml-1 h-3 w-3" />
              </button>
            </div>
          </div>
        </div>
      </div>
      
      <footer className="py-6 text-center text-gray-500 text-sm">
        <p>© {new Date().getFullYear()} LegalAware. All rights reserved.</p>
      </footer>
    </div>
  );
};

export default Login;
