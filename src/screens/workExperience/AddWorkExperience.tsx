import React, { useState } from "react";
import {
    View,
    Text,
    TextInput,
    StyleSheet,
    TouchableOpacity,
} from "react-native";

const AddWorkExperience = () => {
    const [jobTitle, setJobTitle] = useState("");
    const [company, setCompany] = useState("");
    const [startDate, setStartDate] = useState("");
    const [endDate, setEndDate] = useState("");
    const [description, setDescription] = useState("");

    const handleSave = () => {
        // Handle save logic
    };

    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <Text style={styles.backButton}>←</Text>
                <Text style={styles.title}>Add work experience</Text>
            </View>

            <Text style={styles.label}>Job Title</Text>
            <TextInput
                style={styles.input}
                placeholder="Enter your job title"
                placeholderTextColor="#999"
                value={jobTitle}
                onChangeText={setJobTitle}
            />

            <Text style={styles.label}>Company</Text>
            <TextInput
                style={styles.input}
                placeholder="Enter company name"
                placeholderTextColor="#999"
                value={company}
                onChangeText={setCompany}
            />

            <View style={styles.row}>
                <View style={styles.halfContainer}>
                    <Text style={styles.label}>Start Date</Text>
                    <TextInput
                        style={styles.input}
                        placeholder="MM/DD/YYYY"
                        placeholderTextColor="#999"
                        value={startDate}
                        onChangeText={setStartDate}
                    />
                </View>

                <View style={styles.halfContainer}>
                    <Text style={styles.label}>End Date</Text>
                    <TextInput
                        style={styles.input}
                        placeholder="MM/DD/YYYY"
                        placeholderTextColor="#999"
                        value={endDate}
                        onChangeText={setEndDate}
                    />
                </View>
            </View>

            <Text style={styles.label}>Description</Text>
            <TextInput
                style={[styles.input, styles.textArea]}
                placeholder="Write additional information here"
                placeholderTextColor="#999"
                value={description}
                onChangeText={setDescription}
                multiline={true}
            />

            <TouchableOpacity style={styles.saveButton} onPress={handleSave}>
                <Text style={styles.saveButtonText}>SAVE</Text>
            </TouchableOpacity>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: "#f8f8f8",
        padding: 16,
    },
    header: {
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 24,
    },
    backButton: {
        fontSize: 18,
        color: "#000",
        marginRight: 16,
    },
    title: {
        fontSize: 18,
        fontWeight: "bold",
    },
    label: {
        fontSize: 16,
        fontWeight: "500",
        marginBottom: 8,
        color: "#333",
    },
    input: {
        backgroundColor: "#fff",
        borderColor: "#ddd",
        borderWidth: 1,
        borderRadius: 8,
        padding: 12,
        marginBottom: 16,
        fontSize: 16,
        color: "#000",
    },
    row: {
        flexDirection: "row",
        justifyContent: "space-between",
        marginBottom: 16,
    },
    halfContainer: {
        width: "48%",
    },
    textArea: {
        height: 100,
        textAlignVertical: "top",
    },
    saveButton: {
        backgroundColor: "#1e0f6a",
        borderRadius: 8,
        paddingVertical: 16,
        alignItems: "center",
    },
    saveButtonText: {
        color: "#fff",
        fontSize: 18,
        fontWeight: "bold",
    },
});

export default AddWorkExperience;
