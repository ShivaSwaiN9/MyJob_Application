import { useNavigation } from '@react-navigation/native';
import React, { useState } from 'react';
import {
  View,
  Text,
  Image,
  Pressable,
  StyleSheet,
  Switch,
  Modal,
} from 'react-native';

const Setting = () => {
  const navigation = useNavigation();
  const [isNotificationOn, setIsNotificationOn] = useState(false);
  const [isDarkModeOn, setIsDarkModeOn] = useState(false);
  const [isLanguageVisible, setisLanguageVisible] = useState(false);

  const [isModalVisible, setModalVisible] = useState(false);

  const toggleModal = () => setModalVisible(prev => !prev);

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Pressable onPress={() => navigation.goBack()}>
          <Image
            source={require('../../assets/PNG/blackBack.png')} // Replace with your back icon
            style={styles.backImage}
          />
        </Pressable>
      </View>

      {/* Title */}
      <Text style={styles.title}>Setting</Text>

      {/* Settings List */}
      <View style={styles.listcontainer}>
        {/* Notification Section */}
        <View style={styles.imageDiv}>
          <Image
            source={require('../../assets/PNG/notification.png')} // Replace with your image
            style={styles.image}
          />
          <Text style={styles.text}>Notification</Text>
          <Switch
            trackColor={{ false: '#ccc', true: '#4caf50' }} // Gray for off, green for on
            thumbColor={isNotificationOn ? '#fff' : '#fff'} // Keeps the thumb white
            onValueChange={() => setIsNotificationOn(prev => !prev)}
            value={isNotificationOn}
            style={styles.switch}
          />
        </View>

        {/* Dark Mode Section */}
        <View style={styles.imageDiv}>
          <Image
            source={require('../../assets/PNG/darkmode.png')} // Replace with your image
            style={styles.image}
          />
          <Text style={styles.text}>Darkmode</Text>
          <Switch
            trackColor={{ false: '#ccc', true: '#4caf50' }} // Gray for off, green for on
            thumbColor={isDarkModeOn ? '#fff' : '#fff'} // Keeps the thumb white
            onValueChange={() => setIsDarkModeOn(prev => !prev)}
            value={isDarkModeOn}
            style={styles.switch}
          />
        </View>

        {/* Language Section */}
        <Pressable
          style={styles.imageDiv}
          onPress={() => navigation.navigate('LanguageSelection')}>
          <Image
            source={require('../../assets/PNG/languages.png')}
            style={styles.image}
          />
          <Text style={styles.text}>Language</Text>

          <Image
            source={require('../../assets/PNG/rightarrow.png')} // Replace with your right arrow icon
            style={styles.arrow}
          />
        </Pressable>

        {/* Password Section */}
        <Pressable
          style={styles.imageDiv}
          onPress={() => navigation.navigate('PasswordScreen')}>
          <Image
            source={require('../../assets/PNG/password.png')} // Replace with your image
            style={styles.image}
          />
          <Text style={styles.text}>Password</Text>

          <Image
            source={require('../../assets/PNG/rightarrow.png')} // Replace with your right arrow icon
            style={styles.arrow}
          />
        </Pressable>

        {/* Logout Section */}
        <Pressable onPress={toggleModal} style={styles.imageDiv}>
          <Image
            source={require('../../assets/PNG/logout.png')} // Replace with your image
            style={styles.image}
          />
          <Text style={styles.text}>Logout</Text>
          <Image
            source={require('../../assets/PNG/rightarrow.png')} // Replace with your right arrow icon
            style={styles.arrow}
          />
        </Pressable>
      </View>

      <Pressable
        style={[styles.button, styles.applyButton]}
        // onPress={handleSubmit}
        onPress={() => navigation.navigate('MyProfile')}>
        <Text style={styles.buttonText}>Save</Text>
      </Pressable>

      <Modal
        animationType="slide"
        transparent={true}
        visible={isModalVisible}
        onRequestClose={toggleModal}>
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <Text style={styles.title}>Log out</Text>
            <Text style={styles.modalTitle}>
              Are you sure you want to log out?
            </Text>
            <View style={styles.modalButtons}>
              <Pressable
                style={[styles.styleButton, styles.cancelButton]}
                onPress={() => {
                  console.log('Logged out');
                  setModalVisible(false);
                  navigation.navigate('Login'); // Redirect to login screen or handle logout logic
                }}>
                <Text style={styles.buttonText}>Yes</Text>
              </Pressable>
              <Pressable
                style={[styles.styleButton, styles.logoutButton]}
                onPress={toggleModal}
                >
                <Text style={styles.buttonText}>No</Text>
              </Pressable>
            </View>
          </View>
        </View>
      </Modal>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#E5E5E5',
    paddingHorizontal: 20,
    paddingTop: 10,
  },
  header: {
    height: 50,
    justifyContent: 'flex-start',
  },
  backImage: {
    height: 20,
    width: 20,
    position: 'absolute',
    top: 10,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  listcontainer: {
    flex: 0.8,
    flexDirection: 'column',
    marginTop: 20,
  },
  imageDiv: {
    width: '100%',
    height: 60,
    marginBottom: 10,
    backgroundColor: 'white',
    padding: 10,
    borderRadius: 10,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  image: {
    width: 30,
    height: 30,
    resizeMode: 'contain',
  },
  text: {
    fontSize: 16,
    fontWeight: 'bold',
    color: 'black',
    flex: 1, // Takes remaining space between image and switch
    marginLeft: 10,
  },
  switch: {
    marginRight: 10,
  },
  arrow: {
    marginRight: 24, // Optional: Adjust the color of the arrow
  },

  button: {
    backgroundColor: '#C0C0C0', // Orange button
    height: '8%',
    top: '10%',
    // marginVertical: 3,
    borderRadius: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 20,
    fontWeight: '500',
  },
  applyButton: {
    backgroundColor: '#130160',
    justifyContent: 'center',
    left: 50,
    top: '10%',
    // paddingVertical:10,
    width: '60%',
  },
  modalOverlay: {
    flex: 1,
    justifyContent: 'flex-end',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    height: '50%', // Semi-transparent overlay
  },
  modalContent: {
    backgroundColor: 'white',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
    paddingBottom: 40,
    alignItems: 'center',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
    textAlign: 'center',
  },
  modalButtons: {
    flexDirection: 'column', // Arrange buttons vertically
    justifyContent: 'space-between', // Add space between buttons
    width: '100%', // Ensure full width for buttons
    height: 120, // Adjust height to create spacing
  },
  styleButton: {
    height: 50,
    borderRadius: 5,
    justifyContent: 'center',
    alignItems: 'center',
  },
  cancelButton: {
    backgroundColor: '#130160',
  },
  logoutButton: {
    backgroundColor: '#e74c3c',
  },
});

export default Setting;
