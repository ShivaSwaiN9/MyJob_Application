import React, { useState } from 'react';
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    StyleSheet,
    ScrollView,
} from 'react-native';

const AddAppreciation = () => {
    const [awardName, setAwardName] = useState('');
    const [category, setCategory] = useState('');
    const [endDate, setEndDate] = useState('');
    const [description, setDescription] = useState('');

    const handleSave = () => {
        // Logic for saving the appreciation details
        console.log({
            awardName,
            category,
            endDate,
            description,
        });
    };

    return (
        <ScrollView contentContainerStyle={styles.container}>
            <TouchableOpacity style={styles.backButton}>
                <Text style={styles.backButtonText}>←</Text>
            </TouchableOpacity>

            <Text style={styles.header}>Add Appreciation</Text>

            <Text style={styles.label}>Award name</Text>
            <TextInput
                style={styles.input}
                placeholder="Enter award name"
                value={awardName}
                onChangeText={setAwardName}
            />

            <Text style={styles.label}>Category/Achievement achieved</Text>
            <TextInput
                style={styles.input}
                placeholder="Enter category or achievement"
                value={category}
                onChangeText={setCategory}
            />

            <Text style={styles.label}>End date</Text>
            <TextInput
                style={styles.input}
                placeholder="Enter end date"
                value={endDate}
                onChangeText={setEndDate}
            />

            <Text style={styles.label}>Description</Text>
            <TextInput
                style={[styles.input, styles.textArea]}
                placeholder="Write additional information here"
                value={description}
                onChangeText={setDescription}
                multiline
            />

            <TouchableOpacity style={styles.saveButton} onPress={handleSave}>
                <Text style={styles.saveButtonText}>SAVE</Text>
            </TouchableOpacity>
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
        flexGrow: 1,
        padding: 20,
        backgroundColor: '#F5F5F5',
    },
    backButton: {
        marginBottom: 20,
    },
    backButtonText: {
        fontSize: 18,
        color: '#000',
    },
    header: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#000',
        marginBottom: 20,
    },
    label: {
        fontSize: 16,
        color: '#000',
        marginBottom: 8,
    },
    input: {
        borderWidth: 1,
        borderColor: '#CCC',
        borderRadius: 8,
        padding: 12,
        backgroundColor: '#FFF',
        marginBottom: 16,
        fontSize: 16,
    },
    textArea: {
        height: 100,
        textAlignVertical: 'top',
    },
    saveButton: {
        backgroundColor: '#000080', // Navy blue color
        padding: 15,
        borderRadius: 8,
        alignItems: 'center',
    },
    saveButtonText: {
        color: '#FFF',
        fontSize: 18,
        fontWeight: 'bold',
    },
});

export default AddAppreciation;
