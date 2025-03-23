// Add the file-wide annotation to opt into experimental APIs
@file:OptIn(ExperimentalMaterial3Api::class)

package com.example.lawthonupdates

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

// Simply use the system default sans-serif font which is similar to San Francisco on iOS
val sansFontFamily = FontFamily.SansSerif

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MainScreen()
        }
    }
}

@Composable
fun MainScreen() {
    val navController = rememberNavController()

    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        AnimatedGradientBackground() // Background Animation

        // Navigation Setup
        NavHost(navController = navController, startDestination = "login") {
            composable("login") { LoginScreen(navController) }
            composable("home") { HomePage(navController) }
            composable("caseSearch") { CaseSearchScreen(navController) }
            composable("courtsInfo") { CourtsInfoScreen(navController) }
            composable("firInfo") { FIRInfoScreen(navController) }
            composable("cyberAwareness") { CyberAwarenessScreen(navController) }
            composable("learningModules") { LearningModulesScreen(navController) }
            composable("cyberCourse") { CyberCourseScreen(navController) }
            composable("propertyDamageCourse") { PropertyDamageCourseScreen(navController) }
            composable("unpaidLoansCourse") { UnpaidLoansCourseScreen(navController) }
            composable("juvenileMisconductCourse") { JuvenileMisconductCourseScreen(navController) }
            composable("divorceCasesCourse") { DivorceCasesCourseScreen(navController) }
            composable("forum") { ForumScreen(navController) } // Added Forum Screen
        }
    }
}

// Background Animation
@Composable
fun AnimatedGradientBackground() {
    val infiniteTransition = rememberInfiniteTransition(label = "background animation")

    val colorTop by infiniteTransition.animateValue(
        initialValue = Color(0xFF8A9B9C),
        targetValue = Color(0xFF8A9B9C),
        typeConverter = TwoWayConverter(
            convertToVector = { color ->
                AnimationVector4D(color.red, color.green, color.blue, color.alpha)
            },
            convertFromVector = { vector ->
                Color(vector.v1, vector.v2, vector.v3, vector.v4)
            }
        ),
        animationSpec = infiniteRepeatable(
            animation = tween(durationMillis = 5000, easing = LinearEasing),
            repeatMode = RepeatMode.Reverse
        ), label = "color animation"
    )

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    colors = listOf(colorTop, Color(0xFF8A9B9C))
                )
            ))
}

// Login Screen with Navigation
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LoginScreen(navController: NavController) {
    var username by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    val correctUsername = "abcd"
    val correctPassword = "1234"

    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Column(
            modifier = Modifier
                .background(
                    brush = Brush.verticalGradient(
                        colors = listOf(
                            Color(0xCCFFFFFF), // Semi-transparent white
                            Color(0xAAFFFFFF)  // More transparent white
                        )
                    ),
                    shape = RoundedCornerShape(16.dp)
                )
                .padding(24.dp)
                .width(300.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_law),
                contentDescription = "Law Icon",
                tint = Color(0xFFB8860B),
                modifier = Modifier.size(64.dp)
            )

            Spacer(modifier = Modifier.height(10.dp))

            Text(
                "Legal Info Hub",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1B1F3B),
                fontFamily = sansFontFamily
            )

            Spacer(modifier = Modifier.height(20.dp))

            OutlinedTextField(
                value = username,
                onValueChange = { username = it },
                label = { Text("Username", fontFamily = sansFontFamily) },
                colors = OutlinedTextFieldDefaults.colors(
                    unfocusedBorderColor = Color(0x77B8860B),
                    focusedBorderColor = Color(0xFFB8860B),
                    unfocusedLabelColor = Color(0x77000000),
                    focusedLabelColor = Color(0xFFB8860B)
                )
            )

            Spacer(modifier = Modifier.height(10.dp))

            OutlinedTextField(
                value = password,
                onValueChange = { password = it },
                label = { Text("Password", fontFamily = sansFontFamily) },
                visualTransformation = PasswordVisualTransformation(),
                colors = OutlinedTextFieldDefaults.colors(
                    unfocusedBorderColor = Color(0x77B8860B),
                    focusedBorderColor = Color(0xFFB8860B),
                    unfocusedLabelColor = Color(0x77000000),
                    focusedLabelColor = Color(0xFFB8860B)
                )
            )

            Spacer(modifier = Modifier.height(20.dp))

            Button(
                onClick = {
                    if (username == correctUsername && password == correctPassword) {
                        navController.navigate("home")
                    } else {
                        println("Invalid Credentials")
                    }
                },
                colors = ButtonDefaults.buttonColors(containerColor = Color(0xFFB8860B))
            ) {
                Text("Log In", color = Color.White, fontFamily = sansFontFamily)
            }

            Spacer(modifier = Modifier.height(10.dp))

            TextButton(onClick = { println("Forgot Password Clicked") }) {
                Text("Forgot Password?", color = Color(0xFFB8860B), fontFamily = sansFontFamily)
            }
        }
    }
}

// Data class for news items
data class NewsItem(
    val title: String,
    val content: String
)

// News Card Component
@Composable
fun NewsCard(newsItem: NewsItem) {
    Card(
        modifier = Modifier
            .width(300.dp)
            .height(180.dp)
            .padding(horizontal = 8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Text(
                text = newsItem.title,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = newsItem.content,
                fontSize = 14.sp,
                color = Color.DarkGray,
                fontFamily = sansFontFamily
            )
            Spacer(modifier = Modifier.weight(1f))
            Text(
                text = "Read more...",
                fontSize = 14.sp,
                color = Color(0xFFB8860B),
                modifier = Modifier.align(Alignment.End),
                fontFamily = sansFontFamily
            )
        }
    }
}

// Auto-scrolling news carousel
@Composable
fun AutoScrollingNewsCarousel(newsItems: List<NewsItem>) {
    val listState = rememberLazyListState()
    val coroutineScope = rememberCoroutineScope()

    // Auto-scrolling effect
    LaunchedEffect(Unit) {
        while (true) {
            delay(3000) // Scroll every 3 seconds
            val nextIndex = (listState.firstVisibleItemIndex + 1) % newsItems.size
            coroutineScope.launch {
                listState.animateScrollToItem(nextIndex)
            }
        }
    }

    Column {
        Text(
            "Law Buzz: What's New? ",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp),
            fontFamily = sansFontFamily
        )

        LazyRow(
            state = listState,
            contentPadding = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
            modifier = Modifier.fillMaxWidth()
        ) {
            items(newsItems) { newsItem ->
                NewsCard(newsItem)
            }
            // Add duplicates at the end to make scrolling seem continuous
            items(newsItems.take(3)) { newsItem ->
                NewsCard(newsItem)
            }
        }
    }
}

// Categories Section
@Composable
fun CategoriesSection() {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
    ) {
        Text(
            "Browse by Category",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily
        )

        Spacer(modifier = Modifier.height(16.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            CategoryButton("Constitutional", Color(0xFF1E88E5))
            CategoryButton("Criminal", Color(0xFFE53935))
            CategoryButton("Civil", Color(0xFF43A047))
        }

        Spacer(modifier = Modifier.height(8.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            CategoryButton("Corporate", Color(0xFFFFB300))
            CategoryButton("Family", Color(0xFF8E24AA))
            CategoryButton("IP", Color(0xFF00897B))
        }
    }
}

@Composable
fun CategoryButton(text: String, color: Color) {
    Button(
        onClick = { /* Handle click */ },
        colors = ButtonDefaults.buttonColors(containerColor = color),
        shape = RoundedCornerShape(8.dp),
        modifier = Modifier.width(100.dp)
    ) {
        Text(text, fontSize = 12.sp, fontFamily = sansFontFamily)
    }
}

// Case Search Screen with Search Bar
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CaseSearchScreen(navController: NavController) {
    var searchQuery by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        // Search Bar
        OutlinedTextField(
            value = searchQuery,
            onValueChange = { searchQuery = it },
            label = { Text("Search for cases...", fontFamily = sansFontFamily) },
            leadingIcon = {
                Icon(
                    imageVector = Icons.Default.Search,
                    contentDescription = "Search"
                )
            },
            modifier = Modifier.fillMaxWidth(),
            colors = OutlinedTextFieldDefaults.colors(
                unfocusedBorderColor = Color(0x77B8860B),
                focusedBorderColor = Color(0xFFB8860B),
                unfocusedLabelColor = Color(0x77000000),
                focusedLabelColor = Color(0xFFB8860B)
            )
        )

        Spacer(modifier = Modifier.height(16.dp))

        // Display search results or placeholder
        if (searchQuery.isNotEmpty()) {
            Text(
                text = "Search results for: $searchQuery",
                fontSize = 16.sp,
                fontFamily = sansFontFamily
            )
        } else {
            Text(
                text = "Enter a case name or keyword to search",
                fontSize = 16.sp,
                color = Color.Gray,
                fontFamily = sansFontFamily
            )
        }
    }
}

// Courts Section
@Composable
fun CourtsSection(navController: NavController) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        onClick = {
            // Navigate to the Courts Info page
            navController.navigate("courtsInfo")
        }
    ) {
        Row(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_court),
                contentDescription = "Courts Icon",
                modifier = Modifier.size(40.dp),
                tint = Color(0xFF1B1F3B)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = "Courts: Know More About Courts",
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily
            )
        }
    }
}

// FIR Section
@Composable
fun FIRSection(navController: NavController) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        onClick = {
            // Navigate to the FIR Info page
            navController.navigate("firInfo")
        }
    ) {
        Row(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_fir),
                contentDescription = "FIR Icon",
                modifier = Modifier.size(40.dp),
                tint = Color(0xFF1B1F3B)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = "FIR: How to File an FIR?",
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily
            )
        }
    }
}

// Cyber Awareness Section
@Composable
fun CyberAwarenessSection(navController: NavController) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        onClick = {
            // Navigate to the Cyber Awareness page
            navController.navigate("cyberAwareness")
        }
    ) {
        Row(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_cyber),
                contentDescription = "Cyber Awareness Icon",
                modifier = Modifier.size(40.dp),
                tint = Color(0xFF1B1F3B)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = "Cyber Awareness: Stay Safe Online",
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily
            )
        }
    }
}

// Cyber Awareness Screen
@Composable
fun CyberAwarenessScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
    ) {
        // Header with Gradient Background
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(200.dp)
                .background(
                    Brush.verticalGradient(
                        colors = listOf(Color(0xFF1B1F3B), Color(0xFF8A9B9C))
                    )
                ),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "Cyber Awareness: Stay Safe Online",
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold,
                color = Color.White,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(16.dp)
            )
        }

        // Content with Scrollable Column
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp)
        ) {
            Text(
                text = "What is Cyber Awareness?",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "Cyber awareness refers to the knowledge and practices that help individuals and organizations protect themselves from cyber threats such as hacking, phishing, and identity theft.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "Common Cyber Threats",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "1. Phishing: Fraudulent attempts to obtain sensitive information by disguising as a trustworthy entity.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "2. Malware: Malicious software designed to damage or disrupt systems.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "3. Identity Theft: Stealing personal information to commit fraud.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "How to Stay Safe Online?",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "1. Use Strong Passwords: Create unique and complex passwords for all your accounts.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "2. Enable Two-Factor Authentication: Add an extra layer of security to your accounts.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "3. Avoid Suspicious Links: Do not click on links or download attachments from unknown sources.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "4. Keep Software Updated: Regularly update your operating system and applications to patch vulnerabilities.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "Additional Resources",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "For more information, visit the official website of the Indian Computer Emergency Response Team (CERT-In).",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
        }
    }
}

// Updated Courts Info Screen
@Composable
fun CourtsInfoScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
    ) {
        // Header with Gradient Background
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(200.dp)
                .background(
                    Brush.verticalGradient(
                        colors = listOf(Color(0xFF1B1F3B), Color(0xFF8A9B9C))
                    )
                ),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "Indian Judicial System",
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold,
                color = Color.White,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(16.dp)
            )
        }

        // Content with Scrollable Column
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp)
        ) {
            // Supreme Court Section
            CourtInfoCard(
                title = "Supreme Court of India",
                description = "The highest judicial authority in India, located in New Delhi. It has the ultimate jurisdiction over all courts and tribunals in the country.",
                icon = R.drawable.ic_supreme_court
            )

            Spacer(modifier = Modifier.height(16.dp))

            // High Courts Section
            CourtInfoCard(
                title = "High Courts",
                description = "There are 25 High Courts in India, each overseeing one or more states. They have jurisdiction over lower courts and tribunals within their respective states.",
                icon = R.drawable.ic_high_court
            )

            Spacer(modifier = Modifier.height(16.dp))

            // District Courts Section
            CourtInfoCard(
                title = "District Courts",
                description = "These are the lower courts that handle civil and criminal cases at the district level. They are the primary courts of original jurisdiction.",
                icon = R.drawable.ic_district_court
            )

            Spacer(modifier = Modifier.height(16.dp))

            // Specialized Courts Section
            CourtInfoCard(
                title = "Specialized Courts",
                description = "These include family courts, labor courts, and tribunals for specific matters such as taxation, consumer disputes, and environmental issues.",
                icon = R.drawable.ic_specialized_court
            )

            Spacer(modifier = Modifier.height(16.dp))

            // Additional Information
            Text(
                text = "Additional Information",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )

            Text(
                text = "The Indian judicial system is one of the oldest legal systems in the world. It is based on a combination of common law, statutory law, and customary law. The judiciary is independent of the executive and legislative branches of government.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Text(
                text = "The Supreme Court of India was established on January 28, 1950. It is the guardian of the Constitution and has the power of judicial review.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
        }
    }
}

@Composable
fun CourtInfoCard(title: String, description: String, icon: Int) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        shape = RoundedCornerShape(8.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = icon),
                contentDescription = title,
                modifier = Modifier.size(40.dp),
                tint = Color(0xFF1B1F3B)
            )

            Spacer(modifier = Modifier.width(16.dp))

            Column {
                Text(
                    text = title,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )

                Spacer(modifier = Modifier.height(8.dp))

                Text(
                    text = description,
                    fontSize = 14.sp,
                    fontFamily = sansFontFamily
                )
            }
        }
    }
}

// FIR Info Screen
@Composable
fun FIRInfoScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
    ) {
        // Header with Gradient Background
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(200.dp)
                .background(
                    Brush.verticalGradient(
                        colors = listOf(Color(0xFF1B1F3B), Color(0xFF8A9B9C))
                    )
                ),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "FIR: How to File an FIR?",
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold,
                color = Color.White,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(16.dp)
            )
        }

        // Content with Scrollable Column
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp)
        ) {
            Text(
                text = "What is an FIR?",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "An FIR (First Information Report) is a written document prepared by the police when they receive information about the commission of a cognizable offense. It is the first step in the criminal justice process.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "How to File an FIR?",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "1. Visit the Police Station: Go to the police station with jurisdiction over the area where the crime occurred.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "2. Provide Information: Clearly explain the incident to the police officer. Provide all relevant details, including the time, place, and description of the crime.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "3. Verify the FIR: Ensure that the information recorded in the FIR is accurate and complete. You have the right to request a copy of the FIR.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "Important Points to Remember",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "1. Cognizable Offenses: FIRs are filed for cognizable offenses, which are serious crimes where the police can arrest without a warrant.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "2. Non-Cognizable Offenses: For non-cognizable offenses, a complaint is filed instead of an FIR, and the police cannot investigate without a court order.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "3. Legal Rights: You have the right to file an FIR, and the police are legally obligated to register it if the offense is cognizable.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "Additional Resources",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(vertical = 8.dp)
            )
            Text(
                text = "For more information, visit the official website of your local police department or consult a legal professional.",
                fontSize = 16.sp,
                fontFamily = sansFontFamily,
                modifier = Modifier.padding(bottom = 8.dp)
            )
        }
    }
}

// Learning Modules Screen (Hub for Courses)
@Composable
fun LearningModulesScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Learning Modules",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Cyber Crime Awareness Course
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            onClick = {
                // Navigate to Cyber Course
                navController.navigate("cyberCourse")
            }
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_cyber),
                    contentDescription = "Cyber Course Icon",
                    modifier = Modifier.size(40.dp),
                    tint = Color(0xFF1B1F3B)
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = "Cyber Crime Awareness and Prevention",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )
            }
        }

        // Property Damage Course
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            onClick = {
                // Navigate to Property Damage Course
                navController.navigate("propertyDamageCourse")
            }
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_property_damage),
                    contentDescription = "Property Damage Course Icon",
                    modifier = Modifier.size(40.dp),
                    tint = Color(0xFF1B1F3B)
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = "Property Damage: Legal Recourse and Insurance Claims",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )
            }
        }

        // Unpaid Personal Loans Course
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            onClick = {
                // Navigate to Unpaid Personal Loans Course
                navController.navigate("unpaidLoansCourse")
            }
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_unpaid_loans),
                    contentDescription = "Unpaid Loans Course Icon",
                    modifier = Modifier.size(40.dp),
                    tint = Color(0xFF1B1F3B)
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = "Unpaid Personal Loans: Legal Steps and Recovery",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )
            }
        }

        // Juvenile Misconduct Course
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            onClick = {
                // Navigate to Juvenile Misconduct Course
                navController.navigate("juvenileMisconductCourse")
            }
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_juvenile_misconduct),
                    contentDescription = "Juvenile Misconduct Course Icon",
                    modifier = Modifier.size(40.dp),
                    tint = Color(0xFF1B1F3B)
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = "Juvenile Misconduct: Legal Framework and Prevention",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )
            }
        }

        // Divorce Cases Course
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            onClick = {
                // Navigate to Divorce Cases Course
                navController.navigate("divorceCasesCourse")
            }
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_divorce_cases),
                    contentDescription = "Divorce Cases Course Icon",
                    modifier = Modifier.size(40.dp),
                    tint = Color(0xFF1B1F3B)
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = "Divorce Cases: Legal Rights and Procedures",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )
            }
        }
    }
}

// Cyber Course Screen (Detailed Content)
@Composable
fun CyberCourseScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Cyber Crime Awareness and Prevention",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Module 1: Introduction to Cyber Crimes
        Text(
            text = "Module 1: Introduction to Cyber Crimes",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Cybercrime refers to illegal activities conducted using computers or the internet. It encompasses a wide range of malicious actions that exploit digital technologies to cause harm, steal sensitive information, or disrupt systems.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.1: What is Cyber Crime
        Text(
            text = "Lesson 1.1: What is Cyber Crime",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Cybercrime refers to illegal activities conducted using computers or the internet. It encompasses a wide range of malicious actions that exploit digital technologies to cause harm, steal sensitive information, or disrupt systems.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.2: Types of Cybercrime
        Text(
            text = "Lesson 1.2: Types of Cybercrime",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "1. Hacking: Unauthorized access to computer systems, networks, or data.\n" +
                    "2. Phishing: Deceptive emails or messages to trick individuals into revealing personal information.\n" +
                    "3. Identity Theft: Stealing personal information to impersonate someone else.\n" +
                    "4. Online Harassment: Threatening or harassing individuals online.\n" +
                    "5. Ransomware: Malicious software that blocks access to data until a ransom is paid.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Quiz
        Text(
            text = "Quiz: What is the primary goal of ransomware?",
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "A) Steal passwords\nB) Lock data and demand payment\nC) Spread viruses",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )
    }
}

// Home Page Screen with Navigation Drawer and News Feed
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomePage(navController: NavController) {
    val drawerState = rememberDrawerState(initialValue = DrawerValue.Closed)
    val scope = rememberCoroutineScope()
    val newsItems = remember {
        listOf(
            NewsItem("Supreme Court Ruling on Privacy Law", "The Supreme Court has issued a landmark ruling on digital privacy..."),
            NewsItem("New Tax Regulations for 2025", "The government has announced changes to tax laws affecting small businesses..."),
            NewsItem("Legal Tech Conference Announced", "Annual legal technology conference scheduled for June 2025..."),
            NewsItem("Bar Association Updates Requirements", "New continuing education requirements for practicing attorneys..."),
            NewsItem("International Treaty on Cybercrime", "Nations sign new treaty addressing cross-border digital crimes..."),
            NewsItem("Legal Aid Funding Increased", "Government increases budget for legal aid services by 15%..."),
            NewsItem("Patent Law Amendment Proposed", "New legislation aims to streamline patent application process..."),
            NewsItem("Corporate Compliance Deadline Extended", "Regulators extend deadline for new corporate governance rules...")
        )
    }

    ModalNavigationDrawer(
        drawerState = drawerState,
        drawerContent = {
            ModalDrawerSheet {
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    "Legal Info Hub",
                    modifier = Modifier.padding(16.dp),
                    fontSize = 22.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = sansFontFamily
                )
                // Replaced deprecated Divider with HorizontalDivider
                HorizontalDivider(
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(1.dp),
                    color = Color.Gray
                )
                NavigationDrawerItem(
                    label = { Text("Home", fontFamily = sansFontFamily) },
                    selected = true,
                    onClick = {
                        scope.launch { drawerState.close() }
                    }
                )
                NavigationDrawerItem(
                    label = { Text("Learning Modules", fontFamily = sansFontFamily) },
                    selected = false,
                    onClick = {
                        scope.launch { drawerState.close() }
                        navController.navigate("learningModules") // Navigate to Learning Modules
                    }
                )
                NavigationDrawerItem(
                    label = { Text("Case Search", fontFamily = sansFontFamily) },
                    selected = false,
                    onClick = {
                        scope.launch { drawerState.close() }
                        navController.navigate("caseSearch") // Navigate to CaseSearchScreen
                    }
                )
                NavigationDrawerItem(
                    label = { Text("Additional Resources", fontFamily = sansFontFamily) },
                    selected = false,
                    onClick = {
                        scope.launch { drawerState.close() }
                    }
                )
                NavigationDrawerItem(
                    label = { Text("Forum", fontFamily = sansFontFamily) },
                    selected = false,
                    onClick = {
                        scope.launch { drawerState.close() }
                        navController.navigate("forum") // Navigate to Forum Screen
                    }
                )
            }
        }
    ) {
        Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text("Legal Info Hub", fontFamily = sansFontFamily) },
                    navigationIcon = {
                        IconButton(onClick = { scope.launch { drawerState.open() } }) {
                            Icon(
                                imageVector = Icons.Default.Menu,
                                contentDescription = "Menu"
                            )
                        }
                    }
                )
            }
        ) { paddingValues ->
            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(paddingValues)
            ) {
                item {
                    // News Carousel
                    AutoScrollingNewsCarousel(newsItems)

                    // Categories Section
                    CategoriesSection()

                    // Courts Section
                    CourtsSection(navController)

                    // FIR Section
                    FIRSection(navController)

                    // Cyber Awareness Section
                    CyberAwarenessSection(navController)
                }
            }
        }
    }
}

// Property Damage Course Screen
@Composable
fun PropertyDamageCourseScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Property Damage: Legal Recourse and Insurance Claims",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Module 1: Types of Property Damage
        Text(
            text = "Module 1: Types of Property Damage",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Property damage can arise from various causes, including vandalism, natural disasters, and negligence. Understanding the type of damage is essential for determining the appropriate legal and insurance steps.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.1: Vandalism
        Text(
            text = "Lesson 1.1: Vandalism",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Vandalism is a deliberate act of destroying or defacing property. It is considered a criminal offense, and perpetrators can face legal consequences such as fines or imprisonment.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.2: Natural Disasters
        Text(
            text = "Lesson 1.2: Natural Disasters",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Natural disasters are unpredictable events that can cause widespread damage to property. Insurance plays a critical role in such situations, but it's important to understand the specifics of your policy.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Quiz
        Text(
            text = "Quiz: What is the first step to take after discovering property damage?",
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "A) File a police report\nB) Document the damage\nC) Contact your insurance provider",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )
    }
}

// Unpaid Personal Loans Course Screen
@Composable
fun UnpaidLoansCourseScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Unpaid Personal Loans: Legal Steps and Recovery",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Module 1: Steps to Recover Money
        Text(
            text = "Module 1: Steps to Recover Money",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "When a personal loan goes unpaid, the lender has several legal options to recover the money. These steps ensure that the lender's rights are protected while giving the borrower an opportunity to repay the debt.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.1: Send a Legal Notice
        Text(
            text = "Lesson 1.1: Send a Legal Notice",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "The first step in recovering unpaid loans is to send a legal notice to the borrower. This notice formally demands repayment of the loan and outlines the consequences of non-payment.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.2: File a Case in Civil Court
        Text(
            text = "Lesson 1.2: File a Case in Civil Court",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "If the borrower fails to respond to the legal notice or refuses to repay, the lender can file a case in civil court. The court will examine the evidence and issue a judgment.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Quiz
        Text(
            text = "Quiz: What is the first step to recover an unpaid personal loan?",
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "A) File a case in civil court\nB) Send a legal notice\nC) Hire a recovery agency",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )
    }
}

// Juvenile Misconduct Course Screen
@Composable
fun JuvenileMisconductCourseScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Juvenile Misconduct: Legal Framework and Prevention",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Module 1: Understanding Juvenile Law
        Text(
            text = "Module 1: Understanding Juvenile Law",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Juvenile law governs the legal treatment of minors who commit offenses. It differs significantly from the adult legal system, emphasizing rehabilitation over punishment.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.1: Differences Between Juvenile and Adult Legal Systems
        Text(
            text = "Lesson 1.1: Differences Between Juvenile and Adult Legal Systems",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "The juvenile legal system is designed to address the unique needs of minors, focusing on rehabilitation and education rather than punishment. Unlike adults, juveniles are not tried in criminal courts but in juvenile courts.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.2: Focus on Rehabilitation
        Text(
            text = "Lesson 1.2: Focus on Rehabilitation",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Juvenile courts prioritize rehabilitation programs, such as counseling, community service, and educational courses, over incarceration. This approach recognizes that young individuals are still developing and are more likely to change their behavior with guidance and support.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Quiz
        Text(
            text = "Quiz: What is the primary focus of the juvenile legal system?",
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "A) Punishment\nB) Rehabilitation\nC) Incarceration",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )
    }
}

// Divorce Cases Course Screen
@Composable
fun DivorceCasesCourseScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Divorce Cases: Legal Rights and Procedures",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Module 1: Types of Divorce
        Text(
            text = "Module 1: Types of Divorce",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Divorce can be categorized into mutual consent and contested divorce. Understanding the differences between these types is crucial for navigating the legal process.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.1: Mutual Consent Divorce
        Text(
            text = "Lesson 1.1: Mutual Consent Divorce",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Mutual consent divorce occurs when both spouses agree to end the marriage and settle matters like alimony, child custody, and property division amicably. This process is typically faster and less adversarial.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Lesson 1.2: Contested Divorce
        Text(
            text = "Lesson 1.2: Contested Divorce",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "A contested divorce arises when one spouse files for divorce, and the other disputes the grounds or terms, leading to a more prolonged and contentious legal battle.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Quiz
        Text(
            text = "Quiz: What is the key difference between mutual consent and contested divorce?",
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "A) Mutual consent requires both parties to agree, while contested divorce involves disputes.\nB) Mutual consent is faster, while contested divorce takes longer.\nC) Both A and B.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )
    }
}

// Forum Screen with Subreddit Integration
@Composable
fun ForumScreen(navController: NavController) {
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "Forum",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF1B1F3B),
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        // Subreddit Integration for r/IndianLaw
        Text(
            text = "r/IndianLaw",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Join the discussion on Indian law at r/IndianLaw on Reddit. Stay updated with the latest legal discussions, ask questions, and share your insights.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Button to Open r/IndianLaw
        Button(
            onClick = {
                // Open the subreddit in a WebView or external browser
                // You can use WebView or an Intent to open the URL
            },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1B1F3B)),
            modifier = Modifier.padding(bottom = 16.dp)
        ) {
            Text("Open r/IndianLaw", color = Color.White, fontFamily = sansFontFamily)
        }

        // Subreddit Integration for r/LawSchool
        Text(
            text = "r/LawSchool",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Join the discussion on law school at r/LawSchool on Reddit. Get advice, share experiences, and connect with other law students.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Button to Open r/LawSchool
        Button(
            onClick = {
                // Open the subreddit in a WebView or external browser
                // You can use WebView or an Intent to open the URL
            },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1B1F3B)),
            modifier = Modifier.padding(bottom = 16.dp)
        ) {
            Text("Open r/LawSchool", color = Color.White, fontFamily = sansFontFamily)
        }

        // Subreddit Integration for r/Law
        Text(
            text = "r/Law",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Join the discussion on general legal topics at r/Law on Reddit. Stay updated with legal news, case law, and professional discussions.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Button to Open r/Law
        Button(
            onClick = {
                // Open the subreddit in a WebView or external browser
                // You can use WebView or an Intent to open the URL
            },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1B1F3B)),
            modifier = Modifier.padding(bottom = 16.dp)
        ) {
            Text("Open r/Law", color = Color.White, fontFamily = sansFontFamily)
        }

        // Subreddit Integration for r/LegalAdviceIndia
        Text(
            text = "r/LegalAdviceIndia",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(vertical = 8.dp)
        )
        Text(
            text = "Get legal advice specific to India at r/LegalAdviceIndia on Reddit. Ask questions and get guidance from the community.",
            fontSize = 16.sp,
            fontFamily = sansFontFamily,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        // Button to Open r/LegalAdviceIndia
        Button(
            onClick = {
                // Open the subreddit in a WebView or external browser
                // You can use WebView or an Intent to open the URL
            },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1B1F3B)),
            modifier = Modifier.padding(bottom = 16.dp)
        ) {
            Text("Open r/LegalAdviceIndia", color = Color.White, fontFamily = sansFontFamily)
        }
    }
}
