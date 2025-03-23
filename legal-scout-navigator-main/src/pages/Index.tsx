
import { Link } from "react-router-dom";
import { ArrowRight, BookOpen, Shield, Search as SearchIcon, Scale } from "lucide-react";
import { Button } from "@/components/ui/button";
import Navbar from "@/components/Navbar";

const Index = () => {
  const features = [
    {
      title: "Legal News Digest",
      description: "Stay updated with the latest legal news, changes in regulations, and landmark cases.",
      icon: <BookOpen className="h-6 w-6" />,
    },
    {
      title: "Rights Education",
      description: "Learn about your fundamental rights, what they mean, and how they protect you.",
      icon: <Shield className="h-6 w-6" />,
    },
    {
      title: "Case Search",
      description: "Access and search through a database of relevant legal cases and precedents.",
      icon: <SearchIcon className="h-6 w-6" />,
    },
    {
      title: "Legal Resources",
      description: "Find helpful resources including guides, documents, and contact information for legal aid.",
      icon: <Scale className="h-6 w-6" />,
    },
  ];

  return (
    <div className="min-h-screen flex flex-col">
      <Navbar />
      
      <main className="flex-grow">
        {/* Hero Section */}
        <section className="bg-gradient-to-r from-primary/5 to-primary/10 py-20">
          <div className="container mx-auto px-4 sm:px-6 lg:px-8">
            <div className="max-w-3xl mx-auto text-center">
              <h1 className="text-4xl sm:text-5xl font-bold text-gray-900 mb-6 animate-slide-down">
                Legal Awareness for Everyone
              </h1>
              <p className="text-xl text-gray-600 mb-8 animate-slide-down" style={{ animationDelay: "100ms" }}>
                Empowering citizens through accessible legal information, resources, and education.
              </p>
              <div className="flex flex-col sm:flex-row gap-4 justify-center animate-slide-down" style={{ animationDelay: "200ms" }}>
                <Button asChild size="lg">
                  <Link to="/signup">Get Started</Link>
                </Button>
                <Button asChild variant="outline" size="lg">
                  <Link to="/search">
                    Explore Resources
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </Link>
                </Button>
              </div>
            </div>
          </div>
        </section>

        {/* Features Section */}
        <section className="py-16 bg-white">
          <div className="container mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center mb-16">
              <h2 className="text-3xl font-bold text-gray-900">
                Features & Resources
              </h2>
              <p className="text-lg text-gray-600 mt-4 max-w-2xl mx-auto">
                Our platform provides tools and resources to help you navigate the legal landscape with confidence.
              </p>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
              {features.map((feature, index) => (
                <div 
                  key={feature.title}
                  className="bg-white rounded-xl p-6 shadow-sm hover:shadow-md transition-shadow border border-gray-100 animate-fade-in"
                  style={{ animationDelay: `${index * 100}ms` }}
                >
                  <div className="h-12 w-12 bg-primary/10 rounded-lg flex items-center justify-center text-primary mb-4">
                    {feature.icon}
                  </div>
                  <h3 className="text-xl font-semibold text-gray-900 mb-2">
                    {feature.title}
                  </h3>
                  <p className="text-gray-600">
                    {feature.description}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="bg-primary py-16">
          <div className="container mx-auto px-4 sm:px-6 lg:px-8">
            <div className="max-w-3xl mx-auto text-center">
              <h2 className="text-3xl font-bold text-white mb-6">
                Join the Community Today
              </h2>
              <p className="text-xl text-primary-foreground/90 mb-8">
                Create an account to access all features and stay informed about your legal rights.
              </p>
              <Button asChild size="lg" variant="secondary">
                <Link to="/signup">
                  Sign up for free
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Link>
              </Button>
            </div>
          </div>
        </section>
      </main>

      {/* Footer */}
      <footer className="bg-gray-50 py-8 border-t border-gray-200">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center text-gray-500 text-sm">
            <p>© {new Date().getFullYear()} LegalAware. All rights reserved.</p>
            <p className="mt-2">This platform is for educational purposes only and does not constitute legal advice.</p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Index;
