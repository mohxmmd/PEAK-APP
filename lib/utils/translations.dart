import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          // Login Screen
          'login-heading': 'OTP Login',
          'login-subtext-1': 'Please enter your mobile number to request',
          'login-subtext-2': 'an OTP Code',
          'login-mobile': 'Mobile',
          'login-whatsappnumber': 'Whatsapp number',
          'login-getotp': 'Get OTP',
          // OTP Screen
          'otp-subtext-1': 'We’ve sent you the verification code on your',
          'otp-subtext-2': 'WhatsApp',
          'otp-login': 'Login',
          // Registration
          'reg-heading': 'Set Up Profile',
          'reg-continue': 'Continue',
          'reg-finish': 'Finish',
          'reg-personal-info': 'Personal Information',
          'reg-professional-info': 'Professional Information',
          'reg-additional-info': 'Additional Information',
          // Screen1

          'local-address-label': 'Local Address',
          'local-address-hint': 'Type your local address',
          'fathers-name-label': "Father's Name",
          'fathers-name-hint': "Type your father's name",
          'mobile-number-label': 'Mobile Number(with country code)',
          'mobile-number-hint': 'Type your mobile number',
          'contact-number-label': 'Local Contact Number(with country code)',
          'contact-number-hint': 'Type your contact number',
          'email-label': 'Email ID',
          'email-hint': 'Type your email id',
          'marital-status-label': 'Marital Status',
          'marital-status-hint': 'Select an option',
          'marital-status-single': 'Single',
          'marital-status-married': 'Married',
          'marital-status-divorced': 'Divorced',
          'marital-status-widowed': 'Widowed',
          'error-local-address': 'Local address is required',
          'error-fathers-name': "Father's name is required",
          'error-mobile-number': 'Mobile number is required',
          'error-contact-number': 'Contact number is required',
          'error-email': 'Email ID is required',
          'error-marital-status': 'Please select a marital status',
          'invalid-fathers-name': "Only letters and spaces are allowed",
          'invalid-mobile-number':
              'Please enter a valid 10-digit mobile number with country code',
          "error-invalid-email": "Please enter a valid email address",

          // Screen 2
          'highest_education': 'Highest Education',
          'highest_education_hint': 'Select an option',
          'highest_education_error': 'Please select your highest education',
          'course_completed': 'Course Completed',
          'course_completed_hint': 'Type the course completed',
          'course_completed_error': 'Please enter the course completed',
          'country_of_residence': 'Country of Residence',
          'country_of_residence_hint': 'Select an option',
          'country_of_residence_error':
              'Please select your country of residence',
          'city_of_residence': 'City of Residence',
          'city_of_residence_hint': 'Type your city of residence',
          'city_of_residence_error': 'Please enter your city of residence',
          'residential_address': 'Residential Address',
          'residential_address_hint': 'Type your residential address',
          'residential_address_error': 'Please enter your residential address',
          'company_name': 'Company Name',
          'company_name_hint': 'Type your company name',
          'company_name_error': 'Please enter your company name',
          'job_title': 'Job Title',
          'job_title_hint': 'Type your job title',
          'job_title_error': 'Please enter your job title',
          'years_experience': 'Total Years of Experience',
          'years_experience_hint': 'Type your total years of experience',
          'years_experience_error':
              'Please enter your total years of experience',
          'years_experience_invalid': 'Please enter a valid number',
          // Screen 3
          "emergency_contact_name": "Emergency Contact Name",
          "emergency_contact_name_hint": "Enter emergency contact name",
          "emergency_contact_name_error":
              "Please enter the emergency contact name",
          "emergency_contact_name_invalid":
              "Emergency contact name must contain only letters and spaces",

          "emergency_contact_number":
              "Emergency Contact Number(with country code)",
          "emergency_contact_number_hint": "Enter emergency contact number",
          "emergency_contact_number_error":
              "Please enter the emergency contact number",
          "emergency_contact_number_invalid":
              "Please enter a valid phone number with country code",

          "expatriate_since": "Expatriate Since",
          "expatriate_since_hint": "Enter the year you became an expatriate",
          "expatriate_since_error":
              "Please enter the year you became an expatriate",
          "expatriate_since_invalid": "Please enter a valid year",

          "plan_to_stop_expat": "Plan to Stop Expat",
          "plan_to_stop_expat_hint": "Select an option",
          "plan_to_stop_expat_error": "Please select an option",

          // About Screen
          'about_peak': 'About PEAK',
          'welcome_to_peak': 'Welcome to PEAK',
          'description':
              'The Progressive Expats Association of Kareetiparambe is committed to connecting expatriates with their roots, fostering global unity, and driving progressive change in our community.',
          'get_in_touch': 'Get in Touch',
          'inquiries_feedback':
              'For any inquiries, feedback, or collaboration opportunities, feel free to reach out to us through our contact details below.',
          'footer_text':
              '© 2024 PEAK - Progressive Expats Association of Kareetiparambe',
          // Help Center
          'help_center_title': 'Help Center',
          'welcome_help_center': 'Welcome to the Help Center',
          'help_center_intro':
              'Here, you can find answers to your questions, explore FAQs, and contact us if you need further assistance.',
          'faq_title': 'Frequently Asked Questions',
          'faq_question1': 'How do I reset my password?',
          'faq_answer1':
              'To reset your password, go to the settings page and click "Reset Password".',
          'faq_question2': 'How can I contact support?',
          'faq_answer2': 'Visit our website for the latest contact options.',
          'faq_question3': 'What should I do if I encounter an issue?',
          'faq_answer3':
              'If you encounter any issues, please reach out to our support team immediately. We\'ll assist you in resolving it.',
          'contact_title': 'Contact Us',
          'contact_intro':
              'If you have further questions, feel free to reach out to us. We\'re here to help!',
          'website': 'Website: https://www.teampeak.in/',
          'phone': 'Phone: +123-456-7890',
          'footer':
              '© 2024 PEAK - Progressive Expats Association of Kareetiparambe',
          // Dashboard
          'welcome_back': 'Welcome back!',
          'hello_user': 'Hello! @user 👋',
          'profile': 'Profile',
          'settings': 'Settings',
          'about': 'About',
          'help_center': 'Help Center',
          'membership_status': 'Membership Status',
          'active': 'Active',
          'profile_completion': 'Profile Completion',

          // Notification Screen
          'notifications_title': 'Notifications',
          'notifications_empty': 'No Notifications',
          'notifications_check_back': 'Check back later for updates.',

          // Transaction Screen
          'transactions': 'Transactions',
          'transactions_empty': 'No transactions available',

          // Profile Screen
          'profile_title': 'Profile',
          'personal_info': 'Personal Information',
          'professional_info': 'Professional Information',
          'additional_info': 'Additional Information',
          'logout': 'Log out',
          'change_language': 'Change Language',
        },
        'ml': {
          // Login
          'login-heading': 'ഒടിപി ലോഗിൻ',
          'login-subtext-1': 'OTP കോഡ് അഭ്യർത്ഥിക്കാൻ ദയവായി നിങ്ങളുടെ ',
          'login-subtext-2': 'മൊബൈൽ നമ്പർ നൽകുക',
          'login-mobile': 'മൊബൈൽ',
          'login-whatsappnumber': 'വാട്സാപ്പ് നമ്പർ',
          'login-getotp': 'OTP ലഭിക്കൂ',
          // OTP
          'otp-subtext-1': 'ഞങ്ങൾ നിങ്ങളുടെ വാട്ട്സാപ്പിൽ OTP',
          'otp-subtext-2': 'അയച്ചിട്ടുണ്ട്.',
          'otp-login': 'ലോഗിൻ',
          // Registration
          'reg-heading': 'പ്രൊഫൈൽ സെറ്റ് അപ്പ്',
          'reg-personal-info': 'വ്യക്തിഗത വിവരങ്ങൾ',
          'reg-professional-info': 'പ്രൊഫഷണൽ വിവരങ്ങൾ',

          "reg-additional-info": "അനുബന്ധ വിവരങ്ങൾ",
          'reg-finish': '',

          'reg-continue': 'തുടരുക',
          // Screen1
          'local-address-label': 'പ്രാദേശിക വിലാസം',
          'local-address-hint': 'നിങ്ങളുടെ പ്രാദേശിക വിലാസം നൽകുക',
          'fathers-name-label': 'പിതാവിന്റെ പേര്',
          'fathers-name-hint': 'നിങ്ങളുടെ പിതാവിന്റെ പേര് നൽകുക',
          'mobile-number-label': 'മൊബൈൽ നമ്പർ(with country code)',
          'mobile-number-hint': 'നിങ്ങളുടെ മൊബൈൽ നമ്പർ നൽകുക',
          'contact-number-label':
              'പ്രാദേശിക ബന്ധപ്പെടൽ നമ്പർ(with country code)',
          'contact-number-hint': 'നിങ്ങളുടെ ബന്ധപ്പെടൽ നമ്പർ നൽകുക',
          'email-label': 'ഇമെയിൽ ഐഡി',
          'email-hint': 'നിങ്ങളുടെ ഇമെയിൽ ഐഡി നൽകുക',
          'marital-status-label': 'വിവാഹസ്ഥിതി',
          'marital-status-hint': 'ഒരു ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക',
          'marital-status-single': 'വിവാഹിതമല്ല',
          'marital-status-married': 'വിവാഹിതൻ/വിവാഹിത',
          'marital-status-divorced': 'മൊഴിഞ്ഞവൻ/മൊഴിഞ്ഞവൾ',
          'marital-status-widowed': 'വിധവൻ/വിധവ',
          'error-local-address': 'പ്രാദേശിക വിലാസം നൽകേണ്ടതാണ്',
          'error-fathers-name': 'പിതാവിന്റെ പേര് നൽകേണ്ടതാണ്',
          'error-mobile-number': 'മൊബൈൽ നമ്പർ നൽകേണ്ടതാണ്',
          'error-contact-number': 'ബന്ധപ്പെടാനുള്ള നമ്പർ നൽകേണ്ടതാണ്',
          'error-email': 'ഇമെയിൽ ഐഡി നൽകേണ്ടതാണ്',
          'error-marital-status': 'ദയവായി വിവാഹസ്ഥിതിയെടുത്തു നൽകുക',
          'invalid-fathers-name':
              'അക്ഷരങ്ങളും സ്പേസുകളും മാത്രമേ അനുവദിക്കപ്പെടൂ',
          "error-invalid-email": "ദയവായി ശരിയായ ഇമെയിൽ വിലാസം നൽകുക",
          'invalid-mobile-number': 'ശരിയായ 10 അക്ക മൊബൈൽ നമ്പർ നൽകുക',

          // Screen2
          'highest_education': 'ഏറ്റവും ഉയർന്ന വിദ്യാഭ്യാസം',
          'highest_education_hint': 'ഒരു ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക',
          'highest_education_error':
              'ദയവായി നിങ്ങളുടെ വിദ്യാഭ്യാസം തിരഞ്ഞെടുക്കുക',
          'course_completed': 'പൂർണമാക്കിയ കോഴ്‌സ്',
          'course_completed_hint': 'പഠന കോഴ്‌സ് ടൈപ്പ് ചെയ്യുക',
          'course_completed_error': 'ദയവായി പഠന കോഴ്‌സ് പൂരിപ്പിക്കുക',
          'country_of_residence': 'താമസിക്കുന്ന രാജ്യം',
          'country_of_residence_hint': 'ഒരു ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക',
          'country_of_residence_error': 'ദയവായി രാജ്യം തിരഞ്ഞെടുക്കുക',
          'city_of_residence': 'താമസിക്കുന്ന നഗരം',
          'city_of_residence_hint': 'നഗരം ടൈപ്പ് ചെയ്യുക',
          'city_of_residence_error': 'ദയവായി നഗരം പൂരിപ്പിക്കുക',
          'residential_address': 'വിലാസം',
          'residential_address_hint': 'വിലാസം ടൈപ്പ് ചെയ്യുക',
          'residential_address_error': 'ദയവായി വിലാസം പൂരിപ്പിക്കുക',
          'company_name': 'കമ്പനി പേര്',
          'company_name_hint': 'കമ്പനി പേര് ടൈപ്പ് ചെയ്യുക',
          'company_name_error': 'ദയവായി കമ്പനി പേര് പൂരിപ്പിക്കുക',
          'job_title': 'ജോലി',
          'job_title_hint': 'ജോലി ടൈപ്പ് ചെയ്യുക',
          'job_title_error': 'ദയവായി ജോലി പൂരിപ്പിക്കുക',
          'years_experience': 'എക്സ്പീരിയൻസ്',
          'years_experience_hint': 'എക്സ്പീരിയൻസ് ടൈപ്പ് ചെയ്യുക',
          'years_experience_error': 'ദയവായി എക്സ്പീരിയൻസ് പൂരിപ്പിക്കുക',
          'years_experience_invalid': 'ദയവായി ശരിയായ സംഖ്യ പൂരിപ്പിക്കുക',
          // screen 3
          "emergency_contact_name": "ആശങ്കാ ബന്ധുവിന്റെ പേര്",
          "emergency_contact_name_hint":
              "ആശങ്കാ ബന്ധുവിന്റെ പേര് ടൈപ്പ് ചെയ്യുക",
          "emergency_contact_name_error":
              "ദയവായി ആശങ്കാ ബന്ധുവിന്റെ പേര് നൽകുക",
          "emergency_contact_name_invalid":
              "അക്ഷരങ്ങളും സ്പേസുകളും മാത്രമേ അനുവദിക്കപ്പെടൂ",

          "emergency_contact_number":
              "ആശങ്കാ ബന്ധുവിന്റെ ഫോൺ നമ്പർ നമ്പർ(with country code)",
          "emergency_contact_number_hint":
              "ആശങ്കാ ബന്ധുവിന്റെ നമ്പർ ടൈപ്പ് ചെയ്യുക",
          "emergency_contact_number_error":
              "ദയവായി ആശങ്കാ ബന്ധുവിന്റെ ഫോൺ നമ്പർ നൽകുക",
          "emergency_contact_number_invalid":
              "ശരിയായ 10 അക്ക മൊബൈൽ നമ്പർ നൽകുക",

          "expatriate_since": "പ്രവാസി ആയി വന്ന വർഷം",
          "expatriate_since_hint": "എപ്പോഴാണ് നിങ്ങൾ പ്രവാസി ആയി വന്നത്?",
          "expatriate_since_error":
              "ദയവായി നിങ്ങൾ എപ്പോഴാണ് പ്രവാസി ആയി വന്നത് എന്ന് നൽകുക",
          "expatriate_since_invalid": "ദയവായി ഒരു ശരിയായ വർഷം നൽകുക",

          "plan_to_stop_expat": "പ്രവാസം നിർത്താനുള്ള പദ്ധതി",
          "plan_to_stop_expat_hint": "ഒരു ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക",
          "plan_to_stop_expat_error": "ദയവായി ഒരു ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക",

          // About Screen
          'about_peak': 'അബൗട്ട്',
          'welcome_to_peak': 'സ്വാഗതം',
          'description':
              'കരീടിപറമ്പിലെ പ്രൊഗ്രസീവ് എക്സ്പാറ്റ്സ് അസോസിയേഷൻ പ്രവാസികളെ ബന്ധിപ്പിക്കുകയും, ആഗോള ഐക്യം പ്രോത്സാഹിപ്പിക്കുകയും, നമ്മുടെ സമൂഹത്തിൽ പുരോഗമന മാറ്റങ്ങൾ ഉണ്ടാക്കുകയും ചെയ്യുന്നു.',
          'get_in_touch': 'ബന്ധപ്പെടുക',
          'inquiries_feedback':
              'പർവാചനങ്ങൾ, പ്രതികരണങ്ങൾ, അല്ലെങ്കിൽ സഹകരണ അവസരങ്ങൾക്കായി, താഴെ നൽകിയിരിക്കുന്ന ഞങ്ങളുടെ ബന്ധപ്പെടൽ വിശദാംശങ്ങൾ വഴി ഞങ്ങളെ സമീപിക്കുക.',
          'footer_text':
              '© 2024 PEAK - പ്രൊഗ്രസീവ് എക്സ്പാറ്റ്സ് അസോസിയേഷൻ ഓഫ് കരീടിപറമ്പ്',
          // Help Center
          'help_center_title': 'ഹെൽപ്പ് സെന്റർ',
          'welcome_help_center': 'സഹായ കേന്ദ്രത്തിലേക്ക് സ്വാഗതം',
          'help_center_intro':
              'നിങ്ങളുടെ ചോദ്യങ്ങൾക്ക് ഉത്തരം കണ്ടെത്താനും, പതിവായി ചോദിക്കുന്ന ചോദ്യങ്ങൾ എക്സ്പ്ലോർ ചെയ്യാനും, കൂടുതൽ സഹായം ആവശ്യമുണ്ടെങ്കിൽ ഞങ്ങളെ ബന്ധപ്പെടാനും ഇവിടെ കഴിയും.',
          'faq_title': 'പതിവായി ചോദിക്കുന്ന ചോദ്യങ്ങൾ',
          'faq_question1': 'എൻ്റെ പാസ്വേഡ് എങ്ങനെ പുനഃസജ്ജീകരിക്കാം?',
          'faq_answer1':
              'നിങ്ങളുടെ പാസ്വേഡ് പുനഃസജ്ജീകരിക്കാൻ, സെറ്റിംഗ്‌സ് പേജിലേക്ക് പോകുക "Reset Password" ക്ലിക്ക് ചെയ്യുക.',
          'faq_question2': 'സഹായത്തിന് എങ്ങനെ ബന്ധപ്പെടാം?',
          'faq_answer2':
              'നമ്മുടെ വെബ്സൈറ്റ് സന്ദർശിച്ച് ഏറ്റവും പുതിയ ഓപ്ഷനുകൾ കണ്ടെത്തുക.',
          'faq_question3': 'ഒരു പ്രശ്നം നേരിടുമ്പോൾ ഞാൻ എന്ത് ചെയ്യണം?',
          'faq_answer3':
              'നിങ്ങൾക്ക് എന്തെങ്കിലും പ്രശ്നങ്ങൾ നേരിടുകയാണെങ്കിൽ, ഞങ്ങളുടെ സഹായസംഘവുമായി ഉടൻ ബന്ധപ്പെടുക. അത് പരിഹരിക്കാൻ ഞങ്ങൾ സഹായിക്കും.',
          'contact_title': 'ഞങ്ങളെ ബന്ധപ്പെടുക',
          'contact_intro':
              'നിങ്ങൾക്ക് കൂടുതൽ ചോദ്യങ്ങൾ ഉണ്ടെങ്കിൽ, ഞങ്ങളെ ബന്ധപ്പെടാൻ മടിക്കേണ്ട. സഹായത്തിനായി ഞങ്ങൾ ഇവിടെയുണ്ട്!',
          'website': 'വെബ്സൈറ്റ്: https://www.teampeak.in/',
          'phone': 'ഫോൺ: +123-456-7890',
          'footer':
              '© 2024 PEAK - പ്രൊഗ്രസീവ് എക്സ്പാറ്റ്സ് അസോസിയേഷൻ ഓഫ് കരീടിപറമ്പ്',
          // Dashboard
          'welcome_back': 'സ്വാഗതം!',
          'hello_user': 'ഹലോ! @user 👋',
          'profile': 'പ്രൊഫൈൽ',
          'settings': 'സെറ്റിങ്സ്',
          'about': 'അബൗട്ട്',
          'help_center': 'ഹെൽപ്പ് സെന്റർ',
          'membership_status': 'മെംബർഷിപ്പ് സ്റ്റാറ്റസ്',
          'active': 'സജീവം',
          'profile_completion': 'പ്രൊഫൈൽ \n കൊംപ്ലീഷൻ',

          // Notifications
          'notifications_title': 'അറിയിപ്പുകൾ',
          'notifications_empty': 'അറിയിപ്പുകളൊന്നുമില്ല',
          'notifications_check_back':
              'അപ്ഡേറ്റുകൾക്കായി പിന്നീട് പരിശോധിക്കുക.',

          // Transactions
          'transactions': 'ട്രാൻസാക്ഷൻ',
          'transactions_empty': 'ട്രാൻസാക്ഷനുകൾ ഇല്ല',

          // Profile Screen
          'profile_title': 'പ്രൊഫൈൽ',
          'personal_info': 'വ്യക്തിഗത വിവരങ്ങൾ',
          'professional_info': 'പ്രൊഫഷണൽ വിവരങ്ങൾ',
          'additional_info': 'മറ്റ്  വിവരങ്ങൾ',
          'logout': 'ലോഗ് ഔട്ട്',
          'change_language': 'ഭാഷ മാറ്റുക',
        },
      };
}
