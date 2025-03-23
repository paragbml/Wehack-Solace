
import { useState } from "react";
import { Filter, BookOpen, File, FileText, ArrowRight } from "lucide-react";
import Navbar from "@/components/Navbar";
import SearchBar from "@/components/SearchBar";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";

const Search = () => {
  const [searchQuery, setSearchQuery] = useState("");
  const [results, setResults] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showFilters, setShowFilters] = useState(false);

  // Mock results data
  const mockResults = [
    {
      id: 1,
      title: "Consumer Protection Act",
      type: "legislation",
      description: "Comprehensive legislation that protects consumers from unfair business practices and fraud.",
      relevance: "High",
      year: "2010",
      url: "#",
    },
    {
      id: 2,
      title: "Smith v. Retail Corp",
      type: "case",
      description: "Landmark case establishing consumer rights regarding defective products and warranty claims.",
      relevance: "High",
      year: "2018",
      url: "#",
    },
    {
      id: 3,
      title: "Guide to Understanding Your Rights as a Consumer",
      type: "resource",
      description: "Practical guide explaining consumer rights and how to exercise them when dealing with businesses.",
      relevance: "Medium",
      year: "2022",
      url: "#",
    },
    {
      id: 4,
      title: "Fair Credit Reporting Act",
      type: "legislation",
      description: "Legislation that promotes accuracy, fairness, and privacy of information in consumer credit reporting.",
      relevance: "Medium",
      year: "2005",
      url: "#",
    },
    {
      id: 5,
      title: "Johnson v. Credit Bureau",
      type: "case",
      description: "Case involving consumer rights violations related to inaccurate credit reporting and disputes.",
      relevance: "Medium",
      year: "2019",
      url: "#",
    },
  ];

  const handleSearch = (query: string) => {
    setSearchQuery(query);
    setIsLoading(true);
    
    // Simulate search API call
    setTimeout(() => {
      setResults(mockResults);
      setIsLoading(false);
    }, 1000);
  };

  const toggleFilters = () => {
    setShowFilters(!showFilters);
  };

  // Function to get icon based on result type
  const getTypeIcon = (type: string) => {
    switch (type) {
      case "legislation":
        return <BookOpen className="h-5 w-5" />;
      case "case":
        return <FileText className="h-5 w-5" />;
      case "resource":
        return <File className="h-5 w-5" />;
      default:
        return <File className="h-5 w-5" />;
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <Navbar isLoggedIn={true} />
      
      <main className="flex-grow container mx-auto px-4 py-8">
        <section className="mb-8">
          <div className="text-center mb-6">
            <h1 className="text-3xl font-bold mb-2 animate-slide-down">Legal Resource Search</h1>
            <p className="text-muted-foreground max-w-2xl mx-auto animate-slide-down" style={{ animationDelay: "100ms" }}>
              Search for legal cases, legislation, and educational resources
            </p>
          </div>
          
          <div className="flex justify-center mb-4 animate-slide-down" style={{ animationDelay: "200ms" }}>
            <SearchBar 
              onSearch={handleSearch}
              placeholder="Search for legal cases, laws, documents..."
              className="max-w-4xl"
            />
          </div>
          
          <div className="flex justify-center">
            <Button 
              variant="outline" 
              onClick={toggleFilters}
              className="text-sm gap-2"
            >
              <Filter className="h-4 w-4" />
              {showFilters ? "Hide Filters" : "Show Filters"}
            </Button>
          </div>
        </section>
        
        {showFilters && (
          <section className="mb-8 animate-fade-in">
            <Card className="max-w-4xl mx-auto">
              <CardHeader>
                <CardTitle className="text-lg">Search Filters</CardTitle>
                <CardDescription>Refine your search results</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  <div className="space-y-3">
                    <Label>Document Type</Label>
                    <div className="space-y-2">
                      {["Legislation", "Case Law", "Educational Resources"].map((type) => (
                        <div key={type} className="flex items-center space-x-2">
                          <Checkbox id={`type-${type}`} />
                          <Label htmlFor={`type-${type}`} className="text-sm font-normal">
                            {type}
                          </Label>
                        </div>
                      ))}
                    </div>
                  </div>
                  
                  <div className="space-y-3">
                    <Label>Date Range</Label>
                    <div className="grid grid-cols-2 gap-2">
                      <div>
                        <Input type="number" placeholder="From Year" className="w-full" />
                      </div>
                      <div>
                        <Input type="number" placeholder="To Year" className="w-full" />
                      </div>
                    </div>
                  </div>
                  
                  <div className="space-y-3">
                    <Label>Relevance</Label>
                    <div className="space-y-2">
                      {["High", "Medium", "Low"].map((relevance) => (
                        <div key={relevance} className="flex items-center space-x-2">
                          <Checkbox id={`relevance-${relevance}`} />
                          <Label htmlFor={`relevance-${relevance}`} className="text-sm font-normal">
                            {relevance}
                          </Label>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </CardContent>
              <CardFooter className="flex justify-end">
                <Button variant="outline" className="mr-2">
                  Reset
                </Button>
                <Button>
                  Apply Filters
                </Button>
              </CardFooter>
            </Card>
          </section>
        )}
        
        <section>
          {searchQuery ? (
            <>
              <div className="mb-4">
                <h2 className="text-xl font-semibold">
                  {isLoading ? "Searching..." : `Results for "${searchQuery}"`}
                </h2>
                {!isLoading && results.length > 0 && (
                  <p className="text-muted-foreground text-sm">
                    Found {results.length} results
                  </p>
                )}
              </div>
              
              {isLoading ? (
                <div className="space-y-4">
                  {[1, 2, 3].map((i) => (
                    <div 
                      key={i} 
                      className="h-32 bg-gray-100 rounded-lg animate-pulse"
                    ></div>
                  ))}
                </div>
              ) : (
                <div className="space-y-4">
                  {results.map((result, index) => (
                    <Card 
                      key={result.id}
                      className="animate-fade-in overflow-hidden"
                      style={{ animationDelay: `${index * 100}ms` }}
                    >
                      <div className="flex flex-col md:flex-row">
                        <div className="p-4 md:p-6 flex-grow">
                          <div className="flex items-center gap-2 mb-2">
                            <div className="h-8 w-8 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                              {getTypeIcon(result.type)}
                            </div>
                            <span className="text-xs font-medium uppercase text-muted-foreground">
                              {result.type} • {result.year}
                            </span>
                          </div>
                          <h3 className="text-xl font-semibold mb-2">{result.title}</h3>
                          <p className="text-muted-foreground">{result.description}</p>
                        </div>
                        <div className="p-4 md:p-6 md:border-l md:flex md:items-center">
                          <div className="flex flex-row md:flex-col items-center gap-4">
                            <div className="text-center">
                              <span className="block text-xs text-muted-foreground">Relevance</span>
                              <span className={`text-sm font-medium ${
                                result.relevance === "High" ? "text-green-600" : 
                                result.relevance === "Medium" ? "text-amber-600" : "text-gray-600"
                              }`}>
                                {result.relevance}
                              </span>
                            </div>
                            <Button asChild variant="outline" size="sm">
                              <a href={result.url} className="flex items-center gap-1">
                                View <ArrowRight className="h-3 w-3" />
                              </a>
                            </Button>
                          </div>
                        </div>
                      </div>
                    </Card>
                  ))}
                </div>
              )}
              
              {!isLoading && results.length === 0 && (
                <div className="text-center py-12">
                  <h3 className="text-lg font-medium">No results found</h3>
                  <p className="text-muted-foreground mt-1">
                    Try adjusting your search terms or filters
                  </p>
                </div>
              )}
            </>
          ) : (
            <div className="text-center py-12">
              <h2 className="text-xl font-semibold mb-2">
                Search for Legal Information
              </h2>
              <p className="text-muted-foreground max-w-xl mx-auto mb-6">
                Enter keywords above to search for cases, legislation, and resources related to your legal questions.
              </p>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 max-w-3xl mx-auto">
                {[
                  {
                    title: "Legislation",
                    description: "Laws, acts, and regulations",
                    icon: <BookOpen className="h-6 w-6" />,
                  },
                  {
                    title: "Case Law",
                    description: "Court decisions and precedents",
                    icon: <FileText className="h-6 w-6" />,
                  },
                  {
                    title: "Resources",
                    description: "Guides, articles, and educational materials",
                    icon: <File className="h-6 w-6" />,
                  },
                ].map((item, index) => (
                  <Card key={item.title} className="animate-fade-in" style={{ animationDelay: `${index * 100}ms` }}>
                    <CardHeader>
                      <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center text-primary mb-2">
                        {item.icon}
                      </div>
                      <CardTitle className="text-lg">{item.title}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <CardDescription>{item.description}</CardDescription>
                    </CardContent>
                  </Card>
                ))}
              </div>
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

export default Search;
