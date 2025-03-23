
import { useNavigate } from "react-router-dom";
import { toast } from "sonner";
import AuthForm from "@/components/AuthForm";
import Navbar from "@/components/Navbar";

const Signup = () => {
  const navigate = useNavigate();

  const handleSignup = (data: any) => {
    console.log("Signup attempt with:", data);
    
    // Simulate signup process (you'd connect to your auth service here)
    setTimeout(() => {
      // Success scenario for demo
      toast.success("Account created successfully!");
      navigate("/dashboard");
    }, 1500);
  };

  return (
    <div className="min-h-screen flex flex-col bg-gray-50">
      <Navbar />
      
      <div className="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <AuthForm
          type="signup"
          onSubmit={handleSignup}
          className="bg-white p-8 rounded-xl shadow-sm border border-gray-100 animate-fade-in"
        />
      </div>
      
      <footer className="py-6 text-center text-gray-500 text-sm">
        <p>© {new Date().getFullYear()} LegalAware. All rights reserved.</p>
      </footer>
    </div>
  );
};

export default Signup;
