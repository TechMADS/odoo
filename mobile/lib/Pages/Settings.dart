import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool isDarkMode = false;
  Locale _locale = const Locale('en');
  String selectedWallpaper = "Default";
  String email = "example@gmail.com";

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Settings UI",
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: SettingsPage(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
        onLanguageChanged: (locale) {
          setLocale(locale);
        },
        currentLocale: _locale,
        selectedWallpaper: selectedWallpaper,
        onWallpaperChanged: (wallpaper) {
          setState(() {
            selectedWallpaper = wallpaper;
          });
        },
        email: email,
        onEmailChanged: (newEmail) {
          setState(() {
            email = newEmail;
          });
        },
      ),
    );
  }
}

// Translations
Map<String, Map<String, String>> translations = {
  "en": {
    "settings": "Settings UI",
    "common": "Common",
    "language": "Language",
    "select_language": "Select Language",
    "environment": "Environment",
    "account": "Account",
    "phone": "Phone number",
    "email": "Email",
    "signout": "Sign out",
    "security": "Security",
    "lockapp": "Lock app in background",
    "fingerprint": "Use fingerprint",
    "changepassword": "Change password",
    "appearance": "Appearance",
    "darkmode": "Dark Mode",
    "wallpaper": "Wallpaper",
    "misc": "Misc",
    "terms": "Terms of Service",
    "licenses": "Open source licenses",
    "verified": "Verified",
    "save": "Save",
    "currentpassword": "Current Password",
    "newpassword": "New Password",
    "confirmpassword": "Confirm Password",
    "passwordmismatch": "Passwords do not match!",
    "passwordchanged": "Password changed successfully!",
  },
  "ta": {
    "settings": "அமைப்புகள்",
    "common": "பொது",
    "language": "மொழி",
    "select_language": "மொழியை தேர்ந்தெடுக்கவும்",
    "environment": "சூழல்",
    "account": "கணக்கு",
    "phone": "தொலைபேசி எண்",
    "email": "மின்னஞ்சல்",
    "signout": "வெளியேறு",
    "security": "பாதுகாப்பு",
    "lockapp": "பின்புலத்தில் பூட்டு",
    "fingerprint": "விரல் முத்திரை",
    "changepassword": "கடவுச்சொல் மாற்று",
    "appearance": "தோற்றம்",
    "darkmode": "டார்க் மோட்",
    "wallpaper": "வால்பேப்பர்",
    "misc": "இதர",
    "terms": "சேவை விதிமுறைகள்",
    "licenses": "திறந்த மூல உரிமங்கள்",
    "verified": "சரிபார்க்கப்பட்டது",
    "save": "சேமி",
    "currentpassword": "தற்போதைய கடவுச்சொல்",
    "newpassword": "புதிய கடவுச்சொல்",
    "confirmpassword": "கடவுச்சொல் உறுதிசெய்",
    "passwordmismatch": "கடவுச்சொல் பொருந்தவில்லை!",
    "passwordchanged": "கடவுச்சொல் வெற்றிகரமாக மாற்றப்பட்டது!",
  },
  "hi": {
    "settings": "सेटिंग्स",
    "common": "सामान्य",
    "language": "भाषा",
    "select_language": "भाषा चुनें",
    "environment": "पर्यावरण",
    "account": "खाता",
    "phone": "फ़ोन नंबर",
    "email": "ईमेल",
    "signout": "साइन आउट",
    "security": "सुरक्षा",
    "lockapp": "बैकग्राउंड में लॉक करें",
    "fingerprint": "फिंगरप्रिंट का उपयोग करें",
    "changepassword": "पासवर्ड बदलें",
    "appearance": "रूप",
    "darkmode": "डार्क मोड",
    "wallpaper": "वॉलपेपर",
    "misc": "विविध",
    "terms": "सेवा की शर्तें",
    "licenses": "ओपन सोर्स लाइसेंस",
    "verified": "सत्यापित",
    "save": "सहेजें",
    "currentpassword": "वर्तमान पासवर्ड",
    "newpassword": "नया पासवर्ड",
    "confirmpassword": "पासवर्ड की पुष्टि करें",
    "passwordmismatch": "पासवर्ड मेल नहीं खा रहे!",
    "passwordchanged": "पासवर्ड सफलतापूर्वक बदला गया!",
  },
};

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;
  final String selectedWallpaper;
  final Function(String) onWallpaperChanged;
  final String email;
  final Function(String) onEmailChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.currentLocale,
    required this.selectedWallpaper,
    required this.onWallpaperChanged,
    required this.email,
    required this.onEmailChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool lockApp = false;
  bool useFingerprint = false;

  String t(String key) {
    return translations[widget.currentLocale.languageCode]?[key] ??
        translations["en"]![key]!;
  }

  void _showEmailEditor() {
    TextEditingController controller = TextEditingController(text: widget.email);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: t("email"),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.verified, color: Colors.green),
                            const SizedBox(width: 5),
                            Text(
                              t("verified"),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    widget.onEmailChanged(controller.text);
                    Navigator.pop(context);
                  },
                  child: Text(t("save")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPasswordEditor() {
    TextEditingController currentController = TextEditingController();
    TextEditingController newController = TextEditingController();
    TextEditingController confirmController = TextEditingController();

    bool showCurrent = false;
    bool showNew = false;
    bool showConfirm = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            TextField(
                              controller: currentController,
                              obscureText: !showCurrent,
                              decoration: InputDecoration(
                                labelText: t("currentpassword"),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(showCurrent
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setModalState(() {
                                      showCurrent = !showCurrent;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: newController,
                              obscureText: !showNew,
                              decoration: InputDecoration(
                                labelText: t("newpassword"),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      showNew ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () {
                                    setModalState(() {
                                      showNew = !showNew;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: confirmController,
                              obscureText: !showConfirm,
                              decoration: InputDecoration(
                                labelText: t("confirmpassword"),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(showConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setModalState(() {
                                      showConfirm = !showConfirm;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (newController.text != confirmController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t("passwordmismatch"))),
                          );
                          return;
                        }
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t("passwordchanged"))),
                        );
                      },
                      child: Text(t("save")),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(t("wallpaper")),
          children: [
            SimpleDialogOption(
              child: const Text("Default"),
              onPressed: () {
                widget.onWallpaperChanged("Default");
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: const Text("Nature"),
              onPressed: () {
                widget.onWallpaperChanged("Nature");
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: const Text("Abstract"),
              onPressed: () {
                widget.onWallpaperChanged("Abstract");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t("settings")),
        backgroundColor: Colors.blue,
        leading: const BackButton(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: widget.selectedWallpaper == "Nature"
              ? const DecorationImage(
              image: AssetImage("assets/nature.jpg"), fit: BoxFit.cover)
              : widget.selectedWallpaper == "Abstract"
              ? const DecorationImage(
              image: AssetImage("assets/abstract.jpg"), fit: BoxFit.cover)
              : null,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // Common
            _buildSectionHeader(t("common")),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(t("language")),
              trailing: Text(
                widget.currentLocale.languageCode == "en"
                    ? "English"
                    : widget.currentLocale.languageCode == "ta"
                    ? "தமிழ்"
                    : "हिन्दी",
              ),
              onTap: () async {
                final selectedLocale = await showDialog<Locale>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text(t("select_language")),
                    children: [
                      SimpleDialogOption(
                        onPressed: () => Navigator.pop(context, const Locale('en')),
                        child: const Text("English"),
                      ),
                      SimpleDialogOption(
                        onPressed: () => Navigator.pop(context, const Locale('ta')),
                        child: const Text("தமிழ்"),
                      ),
                      SimpleDialogOption(
                        onPressed: () => Navigator.pop(context, const Locale('hi')),
                        child: const Text("हिन्दी"),
                      ),
                    ],
                  ),
                );

                if (selectedLocale != null) {
                  widget.onLanguageChanged(selectedLocale);
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.cloud_outlined),
              title: Text(t("environment")),
              trailing: const Text("Production"),
              onTap: () {},
            ),

            // Account
            _buildSectionHeader(t("account")),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(t("phone")),
              onTap: () => _showInfo(t("phone"), "Your registered phone number"),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(t("email")),
              subtitle: Text(widget.email),
              onTap: _showEmailEditor,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(t("signout")),
              onTap: () => _showInfo(t("signout"), "Signed out successfully"),
            ),

            // Security
            _buildSectionHeader(t("security")),
            SwitchListTile(
              secondary: const Icon(Icons.lock),
              title: Text(t("lockapp")),
              value: lockApp,
              onChanged: (val) => setState(() => lockApp = val),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.fingerprint),
              title: Text(t("fingerprint")),
              value: useFingerprint,
              onChanged: (val) => setState(() => useFingerprint = val),
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: Text(t("changepassword")),
              onTap: _showPasswordEditor,
            ),

            // Appearance
            _buildSectionHeader(t("appearance")),
            SwitchListTile(
              secondary: const Icon(Icons.brightness_6),
              title: Text(t("darkmode")),
              value: widget.isDarkMode,
              onChanged: widget.onThemeChanged,
            ),
            ListTile(
              leading: const Icon(Icons.wallpaper),
              title: Text(t("wallpaper")),
              trailing: Text(widget.selectedWallpaper),
              onTap: _showWallpaperDialog,
            ),

            // Misc
            _buildSectionHeader(t("misc")),
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(t("terms")),
              onTap: () => _showInfo(t("terms"), "All terms go here."),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(t("licenses")),
              onTap: () =>
                  _showInfo(t("licenses"), "Open source licenses details."),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
