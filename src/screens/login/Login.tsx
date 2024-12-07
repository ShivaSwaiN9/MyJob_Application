import React, { useState } from 'react';
import {
  SafeAreaView,
  View,
  Text,
  TextInput,
  Pressable,
  StyleSheet,
  ImageBackground,
  Image,
  Alert,
} from 'react-native';

export default function LoginScreen({navigation}:any) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

    const handleLogin = () => {
        // Directly navigate to the AfterLogin screen
        navigation.navigate('Register');
    };

    const handleForgotPassword = () => {
        Alert.alert('Forgot Password', 'Redirecting to reset password...');
    };

    const handleRegister = () => {
        Alert.alert('Register', 'Redirecting to registration page...');
    };



  return (
    <View style={styles.container}>
       <ImageBackground 
      source={require('../../assets/PNG/loginBG.png')} 
      style={styles.backgroundImage}
      >    
        {/* Logo and Header */}
        <View style={styles.header}>
          <View style={styles.logoContainer}>
            <Image source={require('../../assets/PNG/Logo2.png')} style={styles.logo} />
          </View>
          <Text style={styles.title}>Login to continue</Text>
          <Text style={styles.subtitle}>
            Login with your registered Email ID & password to continue.
          </Text>
        </View>
        </ImageBackground>

        {/* Form */}
        <View style={styles.form}>
          <View style={styles.inputContainer}>
            <Image
              source={require('../../assets/PNG/mail.png')}
              style={styles.inputIcon}
            />
            <TextInput
              style={styles.input}
              placeholder="Login with Email"
              placeholderTextColor="#000"
              value={email}
              onChangeText={setEmail}
              keyboardType="email-address"
              autoCapitalize="none"
            />
          </View>

          <View style={styles.inputContainer}>
            <Image
              source={require('../../assets/PNG/lock.png')}
              style={styles.inputIcon}
            />
            <TextInput
              style={[styles.input, styles.passwordInput]}
              placeholder="Your Password"
              placeholderTextColor="#000"
              value={password}
              onChangeText={setPassword}
              secureTextEntry={!showPassword}
            />
            <Pressable 
              onPress={() => setShowPassword(!showPassword)}
              style={styles.eyeIcon}
            >
              <Image
                source={require('../../assets/PNG/eye.png')}
                style={styles.inputIcon}
              />
            </Pressable>
          </View>

          <Pressable  onPress={handleForgotPassword} >
            <Text style={styles.forgotPassword}>Forgot Password?</Text>
          </Pressable>

          <Pressable style={styles.loginButton} onPress={handleLogin}>
            <Text style={styles.loginButtonText}>Login</Text>
          </Pressable>

          <View style={styles.registerContainer}>
            <Text style={styles.registerText}>Don't have an account? </Text>
            <Pressable onPress={handleRegister}>
              <Text style={styles.registerLink}>Register</Text>
            </Pressable>
          </View>
        </View>
     
   
    </View>
  );
}

const styles = StyleSheet.create({
 container:{
    flex:1,
 },
  backgroundImage: {
    flex: 0.5,
    width: '100%',
  },
  header: {
    alignItems: 'center',
    paddingTop: 60,
    paddingHorizontal: 24,
    borderBottomLeftRadius: 20,
    borderBottomRightRadius: 20,
  },
  logoContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  logo: {
    width:250,
    height: 100,
    resizeMode: 'contain',
  },
  title: {
    fontSize: 24,
    fontWeight: '600',
    marginBottom: 8,
    color: '#000',
  },
  subtitle: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
    marginBottom: 40,
  },
  form: {
    flex:0.5,
    backgroundColor:'#fff',
    paddingHorizontal: 24,
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#E5E5E5',
    borderRadius: 8,
    marginBottom: 16,
    paddingHorizontal: 12,
    height: 48,
  },
  inputIcon: {
    width: 20,
    height: 20,
    marginRight: 8,
  },
  input: {
    flex: 1,
    fontSize: 16,
    color: '#000',
  },
  passwordInput: {
    paddingRight: 40,
  },
  eyeIcon: {
    position: 'absolute',
    right: 12,
  },
  forgotPassword: {
    color: '#3B82F6',
    textAlign: 'right',
    marginBottom: 24,
    fontWeight:'bold',
  },
  loginButton: {
    backgroundColor: '#3B82F6',
    borderRadius: 8,
    height: 48,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 24,
  },
  loginButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  registerContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
  },
  registerText: {
    color: '#666',
  },
  registerLink: {
    color: '#3B82F6',
    fontWeight:'bold',
  },
});


