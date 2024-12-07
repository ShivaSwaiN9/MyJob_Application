import { useNavigation } from '@react-navigation/native';
import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  Image,
  Pressable,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';

const PasswordScreen = () => {
  const navigation = useNavigation();
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [currentPasswordVisible, setCurrentPasswordVisible] = useState(false);
  const [newPasswordVisible, setNewPasswordVisible] = useState(false);
  const [confirmPasswordVisible, setConfirmPasswordVisible] = useState(false);

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
      <Text style={styles.title}>Change Password</Text>

      {/* Input Fields */}
      <View style={styles.form}>
        {/* Current Password */}
        <View style={styles.inputContainer}>
          <Text style={styles.label}>Current Password</Text>
          <View style={styles.passwordField}>
            <TextInput
              style={styles.input}
              secureTextEntry={!currentPasswordVisible}
              placeholder="Enter current password"
              placeholderTextColor="#999"
              value={currentPassword}
              onChangeText={setCurrentPassword}
            />
            <TouchableOpacity
              onPress={() => setCurrentPasswordVisible(!currentPasswordVisible)}
            >
              <Image
                source={
                  currentPasswordVisible
                    ? require('../../assets/PNG/openeye.png') // Eye-open icon
                    : require('../../assets/PNG/eye.png') // Eye-closed icon
                }
                style={styles.eyeIcon}
              />
            </TouchableOpacity>
          </View>
        </View>

        {/* New Password */}
        <View style={styles.inputContainer}>
          <Text style={styles.label}>New Password</Text>
          <View style={styles.passwordField}>
            <TextInput
              style={styles.input}
              secureTextEntry={!newPasswordVisible}
              placeholder="Enter new password"
              placeholderTextColor="#999"
              value={newPassword}
              onChangeText={setNewPassword}
            />
            <TouchableOpacity
              onPress={() => setNewPasswordVisible(!newPasswordVisible)}
            >
              <Image
                source={
                  newPasswordVisible
                    ? require('../../assets/PNG/openeye.png') // Eye-open icon
                    : require('../../assets/PNG/eye.png') // Eye-closed icon
                }
                style={styles.eyeIcon}
              />
            </TouchableOpacity>
          </View>
        </View>

        {/* Confirm Password */}
        <View style={styles.inputContainer}>
          <Text style={styles.label}>Confirm Password</Text>
          <View style={styles.passwordField}>
            <TextInput
              style={styles.input}
              secureTextEntry={!confirmPasswordVisible}
              placeholder="Re-enter new password"
              placeholderTextColor="#999"
              value={confirmPassword}
              onChangeText={setConfirmPassword}
            />
            <TouchableOpacity
              onPress={() =>
                setConfirmPasswordVisible(!confirmPasswordVisible)
              }
            >
              <Image
                source={
                  confirmPasswordVisible
                    ? require('../../assets/PNG/openeye.png') // Eye-open icon
                    : require('../../assets/PNG/eye.png') // Eye-closed icon
                }
                style={styles.eyeIcon}
              />
            </TouchableOpacity>
          </View>
        </View>
      </View>

      {/* Submit Button */}
      <Pressable
        style={styles.button}
        onPress={() => {
          if (newPassword === confirmPassword) {
            console.log('Password successfully changed!');
            // Handle password change logic
          } else {
            console.log('Passwords do not match!');
          }
        }}
      >
        <Text style={styles.buttonText}>Submit</Text>
      </Pressable>

      
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
    marginBottom: 20,
  },
  form: {
    marginVertical: 20,
  },
  inputContainer: {
    marginBottom: 20,
  },
  label: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  passwordField: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 8,
    // borderWidth: 1,
    borderColor: '#ccc',
    paddingHorizontal: 10,
  },
  input: {
    flex: 1,
    height: 50,
    fontSize: 14,
    color: '#333',
  },
  eyeIcon: {
    width: 20,
    height: 20,
    tintColor: '#666',
  },
  button: {
    flex:.2,
    top:'30%',
    backgroundColor: '#130160',
    height: 50,
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 10,
    width:'50%',
    marginLeft:'25%',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
});

export default PasswordScreen;
