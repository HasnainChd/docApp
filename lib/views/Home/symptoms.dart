import 'package:flutter/material.dart';

class SymptomsView extends StatelessWidget {
  final String symptom;

  const SymptomsView({super.key, required this.symptom});

  @override
  Widget build(BuildContext context) {
    // Dummy data for symptoms details
    final symptomsDetails = {
      "Temperature": '''
      Symptoms of High Temperature (Fever)
Elevated Body Temperature:

A body temperature above the normal range (usually over 38°C or 100.4°F).
Sweating:

Excessive sweating as the body tries to cool down.
Chills and Shivering:

Feeling cold and shivering, even when the environment is warm.
Headache:

A common symptom that often accompanies a fever.
Muscle Aches:

Soreness or aching in muscles and joints.
Weakness and Fatigue:

General tiredness and lack of energy.
Loss of Appetite:

Reduced desire to eat.
Dehydration:

Dry mouth, thirst, and less frequent urination.
Sweaty Skin:

Skin may feel hot and sweaty to the touch.
Flushed Complexion:

Reddened or warm skin, particularly in the face.
Irritability:

Feeling easily annoyed or agitated.
Increased Heart Rate:

A faster heartbeat than usual.
Dizziness:

Feeling lightheaded or unsteady.
Nausea or Vomiting:

Feeling sick to the stomach or vomiting.
Confusion or Delirium (in severe cases):

Severe fever can sometimes lead to confusion, especially in older adults.
      ''',
      "Snuffle": '''
      Stuffy or Blocked Nose:

Difficulty breathing through the nose due to blockage or congestion.
Runny Nose:

Excessive nasal discharge, which can be clear, yellow, or green.
Sneezing:

Frequent sneezing as a reaction to nasal irritation.
Postnasal Drip:

Mucus dripping down the back of the throat, leading to a sore throat or cough.
Reduced Sense of Smell and Taste:

Temporary loss or reduction in the ability to smell and taste.
Headache:

Pain or pressure in the forehead, eyes, or temples.
Facial Pain or Pressure:

Sensation of pressure or pain around the nose, cheeks, and eyes.
Cough:

A cough that may be caused by postnasal drip.
Sore Throat:

Irritation or soreness in the throat due to mucus drainage.
Ear Fullness or Pain:

Feeling of fullness or discomfort in the ears, sometimes leading to ear pain.
Watery Eyes:

Excessive tearing or watery eyes.
      ''',
      "Fever": '''
      Symptoms of Fever
Elevated Body Temperature:

Body temperature higher than 38°C (100.4°F).
Sweating:

Increased perspiration as the body attempts to cool down.
Chills and Shivering:

Feeling cold and shivering, even in a warm environment.
Headache:

Pain or discomfort in the head.
Muscle Aches:

Generalized muscle soreness or aches.
Weakness and Fatigue:

Feeling unusually tired and weak.
Loss of Appetite:

Decreased desire to eat.
Dehydration:

Dry mouth, reduced urine output, and thirst.
Sweaty Skin:

Skin may feel hot and clammy to the touch.
Flushed Complexion:

Reddened or warm skin, particularly noticeable in the face.
Irritability:

Increased irritability or moodiness.
Increased Heart Rate:

Elevated heart rate, known as tachycardia.
Dizziness:

Lightheadedness or a feeling of unsteadiness.

      ''',
      "Cough": '''
      Common Causes of Cough
Common Cold or Flu: Viral infections are the most common cause of acute cough.
Allergies: Pollen, dust, pet dander, and other allergens can trigger coughing.
Asthma: Often associated with wheezing and shortness of breath.
Postnasal Drip: Mucus from the nose dripping down the throat.
Acid Reflux (GERD): Stomach acid irritating the throat.
Smoking: Irritation of the airways from smoke.
Chronic Bronchitis: Often associated with COPD in smokers.
Medications: Some medications, like ACE inhibitors for blood pressure, can cause a persistent cough.
Home Remedies
Stay Hydrated: Drink plenty of fluids to help thin mucus.
Honey: A spoonful of honey can soothe the throat.
Humidifier: Adds moisture to the air, which can ease coughing.
Saltwater Gargle: Helps soothe throat irritation.
Throat Lozenges or Hard Candy: Can help keep your throat moist.
Over-the-Counter Medications
Cough Suppressants: Like dextromethorphan, for dry coughs.
Expectorants: Like guaifenesin, to help clear mucus.
Antihistamines: If allergies are the cause.
When to See a Doctor
Persistent Cough: Lasting more than 3 weeks.
Severe Symptoms: High fever, coughing up blood, shortness of breath.
Associated with Other Symptoms: Weight loss, night sweats, or wheezing.
Preventative Measures
Avoid Allergens: Identify and avoid triggers.
Quit Smoking: Reduces chronic cough and risk of respiratory infections.
Vaccinations: Stay updated with flu shots and other vaccines.
If your cough is severe, persistent, or accompanied by other worrying symptoms, it's important to consult a healthcare professional for a proper diagnosis and treatment plan.
      ''',
      "Cold": '''
      Symptoms of a Common Cold
Runny or stuffy nose
Sore throat
Cough
Congestion
Slight body aches or a mild headache
Sneezing
Low-grade fever
General feeling of being unwell (malaise)
Home Remedies and Self-Care
Rest: Your body needs energy to fight off the virus.
Hydration: Drink plenty of fluids like water, herbal teas, and broths to stay hydrated.
Warm Liquids: Drinking warm liquids like tea with honey, soup, or warm water can help soothe a sore throat and ease congestion.
Humidify the Air: Using a humidifier or taking a steamy shower can help relieve congestion.
Saline Nasal Drops/Spray: Helps to relieve nasal congestion.
Gargle with Salt Water: Can soothe a sore throat.
Honey: A spoonful of honey can help alleviate coughing (not recommended for children under 1 year old).
Over-the-Counter Medications
Pain Relievers: Acetaminophen (Tylenol) or ibuprofen (Advil) can help with pain and fever.
Decongestants: Medications like pseudoephedrine can relieve nasal congestion (not recommended for people with certain health conditions).
Antihistamines: May help with runny nose and sneezing.
Cough Syrups: Depending on the type of cough, you might use a suppressant (for a dry cough) or an expectorant (to help clear mucus).
Preventive Measures
Wash Hands Frequently: To prevent the spread of the virus.
Avoid Close Contact: With people who are sick.
Disinfect Surfaces: Regularly clean commonly touched surfaces.
Healthy Lifestyle: A balanced diet, regular exercise, and adequate sleep can strengthen your immune system.
When to See a Doctor
Symptoms Persist Beyond 10 Days: Or get worse.
Severe Symptoms: High fever, difficulty breathing, severe headache, chest pain.
Underlying Health Conditions: If you have asthma, diabetes, or a weakened immune system and are concerned about your symptoms.
If your symptoms are severe or you have concerns about your health, it’s always a good idea to seek medical advice.
      
      '''
    };

    return Scaffold(
        appBar: AppBar(
          title: Text(symptom),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    symptom,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    symptomsDetails[symptom] ?? "No details available.",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
        ),
        );
    }
}