import React, { useState } from 'react';
import {
    View,
    Text,
    TextInput,
    Pressable,
    StyleSheet,
    Alert,
    Image,
    TouchableWithoutFeedback,
    Keyboard,
} from 'react-native';


const RegisterDetails = ({navigation}:any) => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [name, setName] = useState('');
    const [phone, setPhone] = useState('');
    const [gender, setGender] = useState('');
    const [dob, setDob] = useState('');
    const [maritalStatus, setMaritalStatus] = useState('');

    const handleNext = () => {
        // if (!email || !password || !name || !phone || !gender || !dob || !maritalStatus) {
        //     Alert.alert('Error', 'Please fill in all fields to proceed.');
        // } else {
        //     Alert.alert('Success', 'Form submitted successfully!');
        // }
        navigation.navigate('HomeScreen');
    };

    return (
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
            <View style={styles.container}>
                {/* Step Progress */}
                <View style={styles.progressContainer}>
                    <View style={styles.progressBar} />
                </View>
                <Text style={styles.stepText}>STEP 1/4</Text>

                {/* Title */}
                <Text style={styles.title}>Tell us Your Details</Text>

                {/* Email Input */}
                <View style={styles.inputContainer}>
                    <TextInput
                        style={styles.input}
                        placeholder="Enter Email ID"
                        placeholderTextColor="#aaa"
                        value={email}
                        onChangeText={setEmail}
                        keyboardType="email-address"
                        autoCapitalize="none"
                        autoCorrect={false}
                    />
                </View>

                {/* Password Input */}
                <View style={styles.inputContainer}>
                    <TextInput
                        style={styles.input}
                        placeholder="Enter Password"
                        placeholderTextColor="#aaa"
                        value={password}
                        onChangeText={setPassword}
                        secureTextEntry
                    />
                </View>

                {/* Name Input */}
                <View style={styles.inputContainer}>
                    <TextInput
                        style={styles.input}
                        placeholder="Enter your name"
                        placeholderTextColor="#aaa"
                        value={name}
                        onChangeText={setName}
                    />
                </View>

                {/* Phone Input */}
                <View style={styles.inputContainer}>
                    <TextInput
                        style={styles.input}
                        placeholder="Phone no."
                        placeholderTextColor="#aaa"
                        value={phone}
                        onChangeText={setPhone}
                        keyboardType="phone-pad"
                    />
                </View>

                {/* Gender Options */}
                <View style={styles.genderContainer}>
                    <Pressable
                        style={[
                            styles.genderButton,
                            gender === 'Male' && styles.genderButtonSelected,
                        ]}
                        onPress={() => setGender('Male')}>
                        <Text style={styles.genderText}>Male</Text>
                    </Pressable>
                    <Pressable
                        style={[
                            styles.genderButton,
                            gender === 'Female' && styles.genderButtonSelected,
                        ]}
                        onPress={() => setGender('Female')}>
                        <Text style={styles.genderText}>Female</Text>
                    </Pressable>
                    <Pressable
                        style={[
                            styles.genderButton,
                            gender === 'Others' && styles.genderButtonSelected,
                        ]}
                        onPress={() => setGender('Others')}>
                        <Text style={styles.genderText}>Others</Text>
                    </Pressable>
                </View>

                {/* Date of Birth */}
                <View style={styles.inputContainer}>
                    <TextInput
                        style={styles.input}
                        placeholder="Date of Birth"
                        placeholderTextColor="#aaa"
                        value={dob}
                        onChangeText={setDob}
                    />
                </View>

                {/* Marital Status */}
                <View style={styles.maritalContainer}>
                    <Pressable
                        style={[
                            styles.maritalOption,
                            maritalStatus === 'Married' && styles.maritalOptionSelected,
                        ]}
                        onPress={() => setMaritalStatus('Married')}>
                        <Text style={styles.maritalText}>Married</Text>
                    </Pressable>
                    <Pressable
                        style={[
                            styles.maritalOption,
                            maritalStatus === 'Unmarried' && styles.maritalOptionSelected,
                        ]}
                        onPress={() => setMaritalStatus('Unmarried')}>
                        <Text style={styles.maritalText}>Unmarried</Text>
                    </Pressable>
                </View>

                {/* Next Button */}
                <Pressable style={styles.button} onPress={handleNext}>
                    <Text style={styles.buttonText}>Next</Text>
                </Pressable>
            </View>
        </TouchableWithoutFeedback>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 16,
        backgroundColor: '#fff',
    },
    progressContainer: {
        height: 4,
        width: '100%',
        backgroundColor: '#e0e0e0',
        marginBottom: 8,
    },
    progressBar: {
        height: 4,
        width: '25%',
        backgroundColor: '#007BFF',
    },
    stepText: {
        fontSize: 14,
        color: '#555',
        textAlign: 'center',
        marginBottom: 16,
    },
    title: {
        fontSize: 20,
        fontWeight: 'bold',
        color: '#333',
        textAlign: 'center',
        marginBottom: 16,
    },
    inputContainer: {
        marginBottom: 12,
    },
    input: {
        height: 50,
        borderColor: '#ccc',
        borderWidth: 1,
        borderRadius: 8,
        paddingHorizontal: 16,
        backgroundColor: '#fff',
        fontSize: 16,
    },
    genderContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 16,
    },
    genderButton: {
        flex: 1,
        height: 50,
        borderWidth: 1,
        borderColor: '#ccc',
        borderRadius: 8,
        justifyContent: 'center',
        alignItems: 'center',
        marginHorizontal: 4,
        backgroundColor: '#fff',
    },
    genderButtonSelected: {
        backgroundColor: '#007BFF',
    },
    genderText: {
        fontSize: 16,
        color: '#555',
    },
    maritalContainer: {
        flexDirection: 'row',
        justifyContent: 'space-evenly',
        marginBottom: 16,
    },
    maritalOption: {
        flex: 1,
        height: 50,
        borderWidth: 1,
        borderColor: '#ccc',
        borderRadius: 8,
        justifyContent: 'center',
        alignItems: 'center',
        marginHorizontal: 4,
        backgroundColor: '#fff',
    },
    maritalOptionSelected: {
        backgroundColor: '#007BFF',
    },
    maritalText: {
        fontSize: 16,
        color: '#555',
    },
    button: {
        height: 50,
        backgroundColor: '#007BFF',
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: 8,
        marginTop: 16,
    },
    buttonText: {
        fontSize: 18,
        color: '#fff',
        fontWeight: 'bold',
    },
});

export default RegisterDetails;
