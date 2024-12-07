// src/screens/AboutMe.tsx
import React, { useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Modal, TextInput } from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
import { useProfileContext } from '../../context/ProfileContext';

const AboutMe: React.FC = () => {
    const { aboutMe, setAboutMe } = useProfileContext(); // Access context
    const route = useRoute();
    const { showModal } = route.params || {};
    const [isModalVisible, setModalVisible] = useState(showModal || false);
    const [aboutMeText, setAboutMeText] = useState(aboutMe); // Initialize with context value
    const navigation = useNavigation();

    const handleContinue = () => {
        setModalVisible(false);
    };

    const handleSaveChanges = () => {
        setAboutMe(aboutMeText); // Save changes to context
        setModalVisible(false);
        navigation.navigate('Profile', { aboutMeText }); // Pass the updated "About Me" text to the Profile page
    };

    const handleUndoChanges = () => {
        setAboutMeText(aboutMe); // Revert changes to initial value from context
        setModalVisible(false);
    };

    return (
        <View style={styles.container}>
            <Text style={styles.header}>Edit About Me</Text>
            <TextInput
                style={styles.input}
                placeholder="Enter about me..."
                value={aboutMeText}
                onChangeText={setAboutMeText}
                multiline
            />
            <TouchableOpacity style={styles.saveButton} onPress={handleSaveChanges}>
                <Text style={styles.saveButtonText}>Save</Text>
            </TouchableOpacity>

            {/* Modal */}
            <Modal
                transparent
                visible={isModalVisible}
                animationType="slide"
                onRequestClose={() => setModalVisible(false)}
            >
                <View style={styles.modalContainer}>
                    <View style={styles.modalContent}>
                        <Text style={styles.modalHeader}>Undo Changes?</Text>
                        <Text style={styles.modalSubHeader}>
                            Are you sure you want to change what you entered?
                        </Text>
                        <View style={styles.modalButtons}>
                            <TouchableOpacity style={styles.continueButton} onPress={handleContinue}>
                                <Text style={styles.continueText}>Continue Filling</Text>
                            </TouchableOpacity>
                            <TouchableOpacity style={styles.undoButton} onPress={handleUndoChanges}>
                                <Text style={styles.undoText}>Undo Changes</Text>
                            </TouchableOpacity>
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
        backgroundColor: '#f8f9fa',
        padding: 20,
    },
    header: {
        fontSize: 20,
        fontWeight: 'bold',
        marginBottom: 20,
        color: '#333',
    },
    input: {
        borderWidth: 1,
        borderColor: '#ccc',
        borderRadius: 8,
        padding: 10,
        fontSize: 16,
        height: 100,
        textAlignVertical: 'top',
        backgroundColor: '#fff',
        marginBottom: 20,
    },
    saveButton: {
        backgroundColor: '#130160',
        paddingVertical: 10,
        borderRadius: 8,
        alignItems: 'center',
    },
    saveButtonText: {
        color: 'white',
        fontWeight: 'bold',
        fontSize: 16,
    },
    modalContainer: {
        flex: 1,
        justifyContent: 'flex-end',
        backgroundColor: 'rgba(0,0,0,0.5)',
    },
    modalContent: {
        backgroundColor: 'white',
        padding: 20,
        borderTopLeftRadius: 20,
        borderTopRightRadius: 20,
        alignItems: 'center',
    },
    modalHeader: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 10,
        color: '#333',
    },
    modalSubHeader: {
        fontSize: 14,
        color: '#666',
        marginBottom: 20,
        textAlign: 'center',
    },
    modalButtons: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        width: '100%',
    },
    continueButton: {
        flex: 1,
        backgroundColor: '#130160',
        paddingVertical: 10,
        borderRadius: 8,
        alignItems: 'center',
        marginRight: 5,
    },
    continueText: {
        color: 'white',
        fontWeight: 'bold',
    },
    undoButton: {
        flex: 1,
        backgroundColor: '#D6CDFE',
        paddingVertical: 10,
        borderRadius: 8,
        alignItems: 'center',
        marginLeft: 5,
    },
    undoText: {
        color: 'white',
        fontWeight: 'bold',
    },
});

export default AboutMe;
