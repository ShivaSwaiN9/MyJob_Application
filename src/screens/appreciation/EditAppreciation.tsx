import React, { useState } from 'react';
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    StyleSheet,
    ScrollView,
} from 'react-native';
import ModalComponent from '../../component/Modal';

const EditAppreciation = () => {
    const [awardName, setAwardName] = useState('');
    const [category, setCategory] = useState('');
    const [endDate, setEndDate] = useState('');
    const [description, setDescription] = useState('');

    const [isSaveModalVisible, setSaveModalVisible] = useState(false);
    const [isRemoveModalVisible, setRemoveModalVisible] = useState(false);

    const handleSave = () => {
        console.log({
            awardName,
            category,
            endDate,
            description,
        });
        setSaveModalVisible(false); // Close the save modal
    };

    const handleRemove = () => {
        setAwardName('');
        setCategory('');
        setEndDate('');
        setDescription('');
        setRemoveModalVisible(false); // Close the remove modal
    };

    return (
        <ScrollView contentContainerStyle={styles.container}>
            <TouchableOpacity style={styles.backButton}>
                <Text style={styles.backButtonText}>←</Text>
            </TouchableOpacity>

            <Text style={styles.header}>Edit Appreciation</Text>

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

            <View style={styles.buttonContainer}>
                <TouchableOpacity
                    style={[styles.actionButton, styles.removeButton]}
                    onPress={() => setRemoveModalVisible(true)}
                >
                    <Text style={styles.actionButtonText}>REMOVE</Text>
                </TouchableOpacity>

                <TouchableOpacity
                    style={[styles.actionButton, styles.saveButton]}
                    onPress={() => setSaveModalVisible(true)}
                >
                    <Text style={styles.actionButtonText}>SAVE</Text>
                </TouchableOpacity>
            </View>

            {/* Save Confirmation Modal */}
            <ModalComponent
                isVisible={isSaveModalVisible}
                title="Save Changes?"
                message="Are you sure you want to save these changes?"
                onConfirm={handleSave}
                onCancel={() => setSaveModalVisible(false)}
                confirmText="Save"
                cancelText="Cancel"
            />

            {/* Remove Confirmation Modal */}
            <ModalComponent
                isVisible={isRemoveModalVisible}
                title="Remove Appreciation?"
                message="Are you sure you want to remove this appreciation?"
                onConfirm={handleRemove}
                onCancel={() => setRemoveModalVisible(false)}
                confirmText="Remove"
                cancelText="Cancel"
            />
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
    buttonContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginTop: 20,
    },
    actionButton: {
        flex: 1,
        borderRadius: 8,
        paddingVertical: 15,
        marginHorizontal: 5,
        alignItems: 'center',
    },
    removeButton: {
        backgroundColor: '#D6CDFE', // Light purple
    },
    saveButton: {
        backgroundColor: '#000080', // Navy blue
    },
    actionButtonText: {
        color: '#FFF',
        fontSize: 16,
        fontWeight: 'bold',
    },
});

export default EditAppreciation;
