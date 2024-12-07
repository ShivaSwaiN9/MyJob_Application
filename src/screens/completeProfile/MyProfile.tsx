import { useNavigation } from '@react-navigation/native';
import React, { useState } from 'react';
import { View, Image, Pressable, StyleSheet, Text, TextInput, ScrollView } from 'react-native';
import DateTimePicker from "@react-native-community/datetimepicker";

const MyProfile = () => {
  const navigation = useNavigation();
  const [date, setDate] = useState(new Date());
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [gender, setGender] = useState("male");

  const handleDateChange = ({selectedDate}:any) => {
    setShowDatePicker(false);
    if (selectedDate) {
      setDate(selectedDate);
    }
  };

  return (
    <View style={styles.container}>
      {/* Header Container */}
      <View style={styles.header}>
        {/* Background Image */}
        <Pressable>
          <Image
            source={require('../../assets/PNG/Background.png')} // Replace with your image URL or local image source
            style={styles.headerImage}
          />
        </Pressable>
      </View>

      {/* Input Fields */}
      <View style={styles.inputsOverlay}>
        {/* Back, Shared, and Settings Buttons */}
        <View style={styles.designInput}>
          <Pressable onPress={() => navigation.navigate('JobSeeker')}>
            <Image
              source={require('../../assets/PNG/Back.png')} // Replace with your image URL or local image source
            />
          </Pressable>

          <View style={styles.rightButtons}>
            <Pressable>
              <Image
                source={require('../../assets/PNG/Iconshared.png')} // Replace with your image URL or local image source
              />
            </Pressable>

            <Pressable onPress={() => navigation.navigate('Setting')}>
              <Image
                source={require('../../assets/PNG/Iconsetting.png')}
                // Replace with your image URL or local image source
              />
            </Pressable>
          </View>
        </View>

        <View style={styles.profilecontainer}>
          {/* Profile Image */}
          <View style={styles.profileImageContainer}>
            <Image
              source={require('../../assets/PNG/Maskgroup.png')} // Replace with your profile image URL or local image source
              style={styles.profileImage}
            />
          </View>

          {/* Profile Information */}
          <View style={styles.profileInfoContainer}>
            <Text style={styles.profileName}>John Doe</Text>
            <Text style={styles.profileEmail}>john.doe@example.com</Text>
          </View>

          {/* Change Profile Button */}
          <Pressable style={styles.changeProfileButton} onPress={() => navigation.navigate('Profile')}>
            <Text style={styles.changeProfileButtonText}>Change Profile</Text>
          </Pressable>
        </View>
      </View>
      
      {/* Scrollable Form Container */}
      <ScrollView>
        <View style={styles.formcontainer}>
          {/* Fullname */}
          <Text style={styles.label}>Fullname</Text>
          <TextInput style={styles.input} placeholder="Fullname" />

          {/* Date of Birth */}
          <Text style={styles.label}>Date of birth</Text>
          <Pressable
            style={styles.dateInput}
            onPress={() => setShowDatePicker(true)}
          >
            <Text style={styles.label}>{date.toDateString()}</Text>
          </Pressable>
          {showDatePicker && (
            <DateTimePicker
              value={date}
              mode="date"
              display="default"
              onChange={handleDateChange}
            />
          )}

          {/* Gender */}
          <Text style={styles.label}>Gender</Text>
          <View style={styles.genderContainer}>
            {/* Male Gender Radio Button */}
            <Pressable
              style={[styles.radioButtonContainer, gender === "male" && styles.radioButtonSelected]}
              onPress={() => setGender("male")}
            >
              <View style={[styles.radioButton, gender === "male" && styles.radioButtonFilled]}>
                {gender === "male" && <View style={styles.radioButtonInner} />}
              </View>
              <Text style={[styles.radioButtonLabel, gender === "male" && styles.selectedLabel]}>
                Male
              </Text>
            </Pressable>

            {/* Female Gender Radio Button */}
            <Pressable
              style={[styles.radioButtonContainer, gender === "female" && styles.radioButtonSelected]}
              onPress={() => setGender("female")}
            >
              <View style={[styles.radioButton, gender === "female" && styles.radioButtonFilled]}>
                {gender === "female" && <View style={styles.radioButtonInner} />}
              </View>
              <Text style={[styles.radioButtonLabel, gender === "female" && styles.selectedLabel]}>
                Female
              </Text>
            </Pressable>
          </View>

          {/* Email Address */}
          <Text style={styles.label}>Email address</Text>
          <TextInput
            style={styles.input}
            placeholder="Email address"
            keyboardType="email-address"
          />

          {/* Phone Number */}
          <Text style={styles.label}>Phone number</Text>
          <View style={styles.phoneContainer}>
            <TextInput style={styles.phoneCode} placeholder="+1" />
            <TextInput
              style={styles.phoneInput}
              placeholder="Phone number"
              keyboardType="phone-pad"
            />
          </View>

          {/* Location */}
          <Text style={styles.label}>Location</Text>
          <TextInput style={styles.input} placeholder="Location" />

          <Pressable
            style={[styles.button, styles.applyButton]}
            onPress={() => navigation.navigate('MyProfile')}
          >
            <Text style={styles.buttonText}>Apply</Text>
          </Pressable>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F9F9F9',
  },
  header: {
    height: 250,
    position: 'relative', // Makes inputs position relative to this container
  },
  headerImage: {
    width: '100%',
    height: '100%',
  },
  inputsOverlay: {
    position: 'absolute', // Overlay inputs on the image
    top: 20, // Adjust vertical alignment of inputs (relative to the image)
    left: 20,
    right: 20,
  },
  designInput: {
    marginBottom: 10,
    height: 40,
    fontSize: 30,
  },
  rightButtons: {
    flexDirection: 'row', // Align the buttons in a row
    justifyContent: 'flex-end', // Align to the rightmost corner
    alignItems: 'center', // Center buttons vertically if needed
    gap: 20, // Add space between buttons
  },
  profileImageContainer: {
    // marginBottom: 10,
  },
  profileImage: {
    width: 70,
    height: 70,
    borderRadius: 30, // Make the image circular
  },
  profilecontainer: {
    marginBottom: 5,
  },
  profileInfoContainer: {
    alignItems: 'flex-start',
    marginBottom: 10,
  },
  profileName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'white',
  },
  profileEmail: {
    fontSize: 16,
    color: '#777',
  },
  changeProfileButton: {
    backgroundColor: 'rgba(255, 255, 255, 0.1)', // White with 10% opacity
    paddingVertical: 10,
    alignItems: 'center',
    width: '50%',
    borderRadius: 8,
  },
  changeProfileButtonText: {
    color: '#fff',
    fontSize: 16,
  },
  formcontainer: {
    flex: .9, // Ensure the ScrollView occupies all available space
    paddingHorizontal: 20,
    paddingVertical: 15,
    backgroundColor: "#F7F8FA",
    marginBottom: '10%',
  },
  label: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: 8,
    color: "#333",
    
  },
  input: {
    backgroundColor: "#fff",
    borderRadius: 8,
    padding: 12,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: "#E5E5E5",
  },
  dateInput: {
    backgroundColor: "#fff",
    borderRadius: 8,
    padding: 12,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: "#E5E5E5",
    justifyContent: "flex-start",
    flexDirection: "row",
  },
  genderContainer: {
    flexDirection: "row",
    marginBottom: 16,
  },
  radioButtonContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
  },
  radioButton: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: '#7f7f7f',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 8,
  },
  radioButtonFilled: {
    borderColor: '#3B82F6', // Blue border when selected
  },
  radioButtonInner: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: '#3B82F6',
  },
  radioButtonLabel: {
    fontSize: 14,
    color: '#333',
  },
  selectedLabel: {
    fontWeight: 'bold',
    color: '#3B82F6', // Blue color for selected option
  },
  phoneContainer: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  phoneCode: {
    backgroundColor: "#fff",
    borderRadius: 8,
    padding: 12,
    marginRight: 12,
    borderWidth: 1,
    borderColor: "#E5E5E5",
    width: 50,
  },
  phoneInput: {
    backgroundColor: "#fff",
    borderRadius: 8,
    padding: 12,
    flex: 1,
    borderWidth: 1,
    borderColor: "#E5E5E5",
  },
  applyButton: {
    marginTop: 10,
    backgroundColor: '#130160',
    alignSelf: 'center',
    width: '90%', // Button width centered and spans most of the screen
    borderRadius: 8,
    paddingVertical: 15,
    marginTop: 20, // Add margin for separation
  },
  buttonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff',
    textAlign: 'center',
  },
});

export default MyProfile;
