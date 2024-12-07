// EditProfileScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView } from 'react-native';

const EditProfile = ({ navigation }) => {
    const [name, setName] = useState('John Doe');
    const [location, setLocation] = useState('California, USA');
    const [bio, setBio] = useState('Software Developer at XYZ');

    const handleSave = () => {
        // Save profile changes logic here
        navigation.goBack(); // Navigate back to the ProfileScreen
    };

    return (
        <ScrollView style={styles.container}>
            <Text style={styles.header}>Edit Profile</Text>

            <View style={styles.inputContainer}>
                <Text style={styles.label}>Name</Text>
                <TextInput
                    style={styles.input}
                    value={name}
                    onChangeText={setName}
                />

                <Text style={styles.label}>Location</Text>
                <TextInput
                    style={styles.input}
                    value={location}
                    onChangeText={setLocation}
                />

                <Text style={styles.label}>Bio</Text>
                <TextInput
                    style={[styles.input, styles.textArea]}
                    value={bio}
                    onChangeText={setBio}
                    multiline
                />

                <TouchableOpacity style={styles.saveButton} onPress={handleSave}>
                    <Text style={styles.saveButtonText}>Save Changes</Text>
                </TouchableOpacity>
            </View>
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f8f9fa',
        padding: 20,
    },
    header: {
        fontSize: 20,
        fontWeight: 'bold',
        marginBottom: 20,
        textAlign: 'center',
    },
    inputContainer: {
        marginBottom: 20,
    },
    label: {
        fontSize: 16,
        marginBottom: 8,
        color: '#333',
    },
    input: {
        backgroundColor: '#fff',
        borderRadius: 10,
        padding: 10,
        marginBottom: 15,
        elevation: 1,
    },
    textArea: {
        height: 100,
        textAlignVertical: 'top',
    },
    saveButton: {
        backgroundColor: '#4A00E0',
        padding: 15,
        borderRadius: 10,
        alignItems: 'center',
    },
    saveButtonText: {
        color: '#fff',
        fontSize: 16,
        fontWeight: 'bold',
    },
});

export default EditProfile;