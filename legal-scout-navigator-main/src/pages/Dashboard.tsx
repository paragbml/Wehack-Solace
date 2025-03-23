
import { useState, useEffect } from "react";
import Navbar from "@/components/Navbar";
import NewsCard from "@/components/NewsCard";
import SearchBar from "@/components/SearchBar";
import { toast } from "sonner";

const Dashboard = () => {
  const [newsItems, setNewsItems] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  // Simulated news data
  const mockNews = [
    {
      id: 1,
      title: "Supreme Court Rules on Consumer Rights Case",
      description: "In a landmark decision, the court established new precedents for how companies must handle customer data and privacy concerns.",
      date: "June 12, 2023",
      source: "Legal Tribune",
      url: "#",
    },
    {
      id: 2,
      title: "New Legislation Expands Tenant Protections",
      description: "A new law provides additional safeguards for renters, including longer notice periods and stricter regulations on security deposits.",
      date: "May 28, 2023",
      source: "Housing Rights Network",
      url: "#",
    },
    {
      id: 3,
      title: "Employment Law Changes Take Effect Next Month",
      description: "Employers must prepare for significant changes to overtime regulations and worker classification rules beginning July 1.",
      date: "June 5, 2023",
      source: "Labor Rights Journal",
      url: "#",
    },
    {
      id: 4,
      title: "Consumer Protection Agency Issues New Guidelines",
      description: "The guidelines address deceptive advertising practices in digital media and establish clearer standards for online retailers.",
      date: "June 10, 2023",
      source: "Consumer Watch",
      url: "#",
    },
    {
      id: 5,
      title: "Legal Aid Clinics Expand Services Nationwide",
      description: "A new funding initiative will increase access to free legal services for low-income individuals in underserved communities.",
      date: "May 15, 2023",
      source: "Access to Justice Report",
      url: "#",
    },
    {
      id: 6,
      title: "Digital Privacy Law Reform Proposed",
      description: "Legislators have introduced a comprehensive bill that would overhaul how companies collect, store, and share personal data.",
      date: "June 8, 2023",
      source: "Tech Policy Center",
      url: "#",
    },
  ];

  useEffect(() => {
    // Simulate API call to fetch news
    setTimeout(() => {
      setNewsItems(mockNews);
      setIsLoading(false);
    }, 1000);
  }, []);

  const handleSearch = (query: string) => {
    toast.info(`Searching for: ${query}`);
    // In a real app, you would navigate to search page or filter results
  };

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <Navbar isLoggedIn={true} />
      
      <main className="flex-grow container mx-auto px-4 py-8">
        <section className="mb-10">
          <div className="text-center mb-8">
            <h1 className="text-3xl font-bold mb-2 animate-slide-down">Welcome to Your Legal Dashboard</h1>
            <p className="text-muted-foreground max-w-2xl mx-auto animate-slide-down" style={{ animationDelay: "100ms" }}>
              Stay informed with the latest legal news and explore resources relevant to your interests.
            </p>
          </div>
          
          <div className="flex justify-center mb-10 animate-slide-down" style={{ animationDelay: "200ms" }}>
            <SearchBar onSearch={handleSearch} />
          </div>
        </section>
        
        <section>
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-semibold">Latest Legal News</h2>
            <a href="#" className="text-primary text-sm font-medium hover:underline">
              View all →
            </a>
          </div>
          
          {isLoading ? (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {[1, 2, 3].map((i) => (
                <div 
                  key={i} 
                  className="w-full h-[280px] rounded-lg bg-gray-100 animate-pulse"
                ></div>
              ))}
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {newsItems.map((news, index) => (
                <NewsCard
                  key={news.id}
                  title={news.title}
                  description={news.description}
                  date={news.date}
                  source={news.source}
                  url={news.url}
                  className="animate-fade-in"
                  style={{ animationDelay: `${index * 100}ms` }}
                />
              ))}
            </div>
          )}
        </section>
      </main>
      
      <footer className="bg-gray-50 py-6 border-t border-gray-200">
        <div className="container mx-auto px-4 text-center text-gray-500 text-sm">
          <p>© {new Date().getFullYear()} LegalAware. All rights reserved.</p>
          <p className="mt-2">This platform is for educational purposes only and does not constitute legal advice.</p>
        </div>
      </footer>
    </div>
  );
};

export default Dashboard;
