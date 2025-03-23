
import { ArrowUpRight } from "lucide-react";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { cn } from "@/lib/utils";

interface NewsCardProps {
  title: string;
  description: string;
  date: string;
  source: string;
  url: string;
  className?: string;
  style?: React.CSSProperties;
}

const NewsCard = ({ title, description, date, source, url, className, style }: NewsCardProps) => {
  return (
    <Card className={cn("w-[350px] h-[280px] flex flex-col transition-all duration-300 hover:shadow-md", className)} style={style}>
      <CardHeader className="p-4 pb-0">
        <CardTitle className="text-xl line-clamp-2">{title}</CardTitle>
        <CardDescription className="text-xs mt-1">{date} · {source}</CardDescription>
      </CardHeader>
      <CardContent className="p-4 pt-2 flex-grow">
        <p className="text-sm text-muted-foreground line-clamp-4">{description}</p>
      </CardContent>
      <CardFooter className="p-4 pt-0">
        <a 
          href={url} 
          target="_blank" 
          rel="noopener noreferrer"
          className="text-sm font-medium text-primary flex items-center gap-1 hover:underline"
        >
          Read more <ArrowUpRight className="h-3 w-3" />
        </a>
      </CardFooter>
    </Card>
  );
};

export default NewsCard;
