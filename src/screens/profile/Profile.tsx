import React, { useState, useEffect } from 'react';
import {
    View,
    Text,
    ImageBackground,
    StyleSheet,
    TouchableOpacity,
    ScrollView,
    Image,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { useProfileContext } from '../../context/ProfileContext';

const ProfileScreen = () => {
    const navigation = useNavigation();
    const { aboutMe, workExperience, appreciation, skills, education, language, resume } = useProfileContext();

    // Local state to track if data has been added
    const [dataAdded, setDataAdded] = useState({
        aboutMe: false,
        workExperience: false,
        appreciation: false,
        skills: false,
        education: false,
        language: false,
        resume: false,
    });

    useEffect(() => {
        // Check if data exists, and update the state accordingly
        setDataAdded({
            aboutMe: !!aboutMe,
            workExperience: workExperience.length > 0,
            appreciation: appreciation && appreciation.length > 0,
            skills: skills && skills.length > 0,
            education: education && education.length > 0,
            language: language && language.length > 0,
            resume: !!resume,
        });
    }, [aboutMe, workExperience, appreciation, skills, education, language, resume]);

    // Define profileOptions here
    const profileOptions = [
        { label: 'About me', icon: require('../../assets/PNG/Person.png') },
        { label: 'Work experience', icon: require('../../assets/PNG/experiene.png') },
        { label: 'Skill', icon: require('../../assets/PNG/Skill.png') },
        { label: 'Education', icon: require('../../assets/PNG/Education.png') },
        { label: 'Language', icon: require('../../assets/PNG/Language.png') },
        { label: 'Appreciation', icon: require('../../assets/PNG/Appreciation.png') },
        { label: 'Resume', icon: require('../../assets/PNG/Resume.png') },
    ];

    return (
        <ScrollView style={styles.container}>
            {/* Header Section */}
            <ImageBackground
                source={require('../../assets/PNG/Background.png')}
                style={styles.headerContainer}
            >
                {/* Top Right Buttons */}
                <View style={styles.topRightContainer}>
                    <TouchableOpacity>
                        <Image source={require('../../assets/PNG/Setting.png')} style={styles.icon} />
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.iconSpacing}>
                        <Image source={require('../../assets/PNG/Share.png')} style={styles.icon} />
                    </TouchableOpacity>
                </View>

                {/* Bottom Row */}
                <View style={styles.bottomRow}>
                    <Text style={styles.statText}>120k Followers</Text>
                    <Text style={styles.statText}>23k Following</Text>
                    <TouchableOpacity style={styles.editProfileButton} onPress={() => navigation.navigate('EditProfile')}>
                        <Text style={styles.editProfileText}>Edit Profile</Text>
                    </TouchableOpacity>
                </View>

                {/* Location */}
                <View style={styles.locationContainer}>
                    <Text style={styles.locationText}>California, USA</Text>
                </View>
            </ImageBackground>

            {/* Profile Options */}
            <View style={styles.optionsContainer}>
                {profileOptions.map((option, index) => (
                    <View key={index}>
                        {/* Profile Option Row */}
                        <View style={styles.optionRow}>
                            <View style={styles.optionLeft}>
                                <Image source={option.icon} style={styles.icon} />
                                <Text style={styles.optionText}>{option.label}</Text>
                            </View>
                            <TouchableOpacity
                                style={styles.addButton}
                                onPress={() => {
                                    if (option.label === 'About me') {
                                        navigation.navigate('AboutMe');
                                    } else if (option.label === 'Work experience') {
                                        navigation.navigate('AddWorkExperience');
                                    } else if (option.label === 'Skill') {
                                        navigation.navigate('AddSkill');
                                    } else if (option.label === 'Education') {
                                        navigation.navigate('AddEducation');
                                    } else if (option.label === 'Language') {
                                        navigation.navigate('LanguageScreen');
                                    } else if (option.label === 'Appreciation') {
                                        navigation.navigate('AddAppreciation');
                                    } else if (option.label === 'Resume') {
                                        navigation.navigate('AddResume');
                                    }
                                }}
                            >
                                {/* Show Add icon if no data is added, otherwise show Edit icon */}
                                <Image
                                    source={
                                        dataAdded[option.label.toLowerCase().replace(' ', '')]
                                            ? require('../../assets/PNG/Edit.png')
                                            : require('../../assets/PNG/Add.png')
                                    }
                                    style={styles.icon}
                                />
                            </TouchableOpacity>
                        </View>

                        {/* Sections for different data */}
                        {option.label === 'About me' && (
                            <View style={styles.aboutMeContainer}>
                                <View style={styles.aboutMeRow}>
                                    <Text style={styles.aboutMeText}>
                                        {aboutMe || "No 'About Me' text added yet."}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate('AboutMe', { showModal: true })}
                                    >
                                        <Image
                                            source={require('../../assets/PNG/Edit.png')}
                                            style={styles.aboutMeIcon}
                                        />
                                    </TouchableOpacity>
                                </View>
                            </View>
                        )}

                        {option.label === 'Work experience' && (
                            <View style={styles.workExperienceContainer}>
                                <View style={styles.workExperienceRow}>
                                    <Text style={styles.workExperienceText}>
                                        {workExperience.length > 0
                                            ? 'Work Experience Added'
                                            : 'No Work Experience Added Yet'}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate('EditWorkExperience')}
                                    >
                                        <Image
                                            source={require('../../assets/PNG/Edit.png')}
                                            style={styles.workExperienceIcon}
                                        />
                                    </TouchableOpacity>
                                </View>

                                {workExperience.length > 0 ? (
                                    <View>
                                        {workExperience.map((work, index) => (
                                            <View key={index} style={styles.workItem}>
                                                <Text style={styles.workTitle}>{work.jobTitle}</Text>
                                                <Text style={styles.workCompany}>{work.company}</Text>
                                                <Text style={styles.workDates}>
                                                    {work.startDate} - {work.endDate}
                                                </Text>
                                                <Text style={styles.workDescription}>{work.description}</Text>
                                            </View>
                                        ))}
                                    </View>
                                ) : null}
                            </View>
                        )}

                        {option.label === 'Appreciation' && (
                            <View style={styles.appreciationContainer}>
                                <View style={styles.appreciationRow}>
                                    <Text style={styles.appreciationText}>
                                        {appreciation && appreciation.length > 0
                                            ? 'Appreciation Added'
                                            : 'No Appreciation Added Yet'}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate('EditAppreciation')}
                                    >
                                        <Image
                                            source={require('../../assets/PNG/Edit.png')}
                                            style={styles.appreciationIcon}
                                        />
                                    </TouchableOpacity>
                                </View>

                                {appreciation && appreciation.length > 0 && (
                                    <View>
                                        {appreciation.map((item, index) => (
                                            <View key={index} style={styles.appreciationItem}>
                                                <Text style={styles.appreciationTitle}>{item.awardName}</Text>
                                                <Text style={styles.appreciationCategory}>{item.category}</Text>
                                                <Text style={styles.appreciationDates}>{item.endDate}</Text>
                                                <Text style={styles.appreciationDescription}>{item.description}</Text>
                                            </View>
                                        ))}
                                    </View>
                                )}
                            </View>
                        )}

                        {option.label === 'Skill' && (
                            <View style={styles.skillContainer}>
                                <View style={styles.skillRow}>
                                    <Text style={styles.skillText}>
                                        {skills && skills.length > 0
                                            ? "Skills Added"
                                            : "No Skills Added Yet"}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate("EditSkill", { skills })}
                                    >
                                        <Image
                                            source={require("../../assets/PNG/Edit.png")}
                                            style={styles.skillIcon}
                                        />
                                    </TouchableOpacity>
                                </View>

                                {skills && skills.length > 0 && (
                                    <View>
                                        {skills.map((item, index) => (
                                            <View key={index} style={styles.skillItem}>
                                                <Text style={styles.skillTitle}>{item.name}</Text>
                                            </View>
                                        ))}
                                    </View>
                                )}
                            </View>
                        )}

                        {/* Add Education, Language, and Resume sections */}
                        {option.label === 'Education' && (
                            <View style={styles.educationContainer}>
                                <View style={styles.educationRow}>
                                    <Text style={styles.educationText}>
                                        {education && education.length > 0
                                            ? 'Education Added'
                                            : 'No Education Added Yet'}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate('EditEducation')}
                                    >
                                        <Image
                                            source={require('../../assets/PNG/Edit.png')}
                                            style={styles.educationIcon}
                                        />
                                    </TouchableOpacity>
                                </View>
                            </View>
                        )}

                        {option.label === 'Language' && (
                            <View style={styles.languageContainer}>
                                <View style={styles.languageRow}>
                                    <Text style={styles.languageText}>
                                        {language && language.length > 0
                                            ? 'Languages Added'
                                            : 'No Languages Added Yet'}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate('EditLanguage')}
                                    >
                                        <Image
                                            source={require('../../assets/PNG/Edit.png')}
                                            style={styles.languageIcon}
                                        />
                                    </TouchableOpacity>
                                </View>
                            </View>
                        )}

                        {option.label === 'Resume' && (
                            <View style={styles.resumeContainer}>
                                <View style={styles.resumeRow}>
                                    <Text style={styles.resumeText}>
                                        {resume ? 'Resume Added' : 'No Resume Added Yet'}
                                    </Text>
                                    <TouchableOpacity
                                        onPress={() => navigation.navigate('EditResume')}
                                    >
                                        <Image
                                            source={require('../../assets/PNG/Edit.png')}
                                            style={styles.resumeIcon}
                                        />
                                    </TouchableOpacity>
                                </View>
                            </View>
                        )}
                    </View>
                ))}
            </View>
        </ScrollView>
    );
};


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f8f9fa',
    },
    headerContainer: {
        height: 250,
        justifyContent: 'space-between',
        padding: 20,
        borderBottomLeftRadius: 20,
        borderBottomRightRadius: 20,
        backgroundColor: 'lightblue',
    },
    topRightContainer: {
        flexDirection: 'row',
        justifyContent: 'flex-end',
        width: '30%',
        position: 'absolute',
        top: 20,
        right: 20,
    },
    icon: {
        width: 25,
        height: 25,
    },
    iconSpacing: {
        marginLeft: 20,
    },
    bottomRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        position: 'absolute',
        bottom: 70,
        left: 20,
        right: 20,
    },
    statText: {
        color: 'white',
        fontSize: 14,
        fontWeight: 'bold',
    },
    editProfileButton: {
        backgroundColor: 'white',
        paddingVertical: 5,
        paddingHorizontal: 10,
        borderRadius: 10,
        borderWidth: 1,
        borderColor: 'lightgray',
        marginLeft: 10,
    },
    editProfileText: {
        color: 'blue',
        fontWeight: 'bold',
    },
    locationContainer: {
        position: 'absolute',
        bottom: 50,
        left: 20,
    },
    locationText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
    optionsContainer: {
        padding: 20,
    },
    optionRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginVertical: 10,
    },
    optionLeft: {
        flexDirection: 'row',
        alignItems: 'center',
    },
    optionText: {
        fontSize: 16,
        marginLeft: 10,
    },
    aboutMeContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    aboutMeRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    aboutMeText: {
        fontSize: 14,
        color: 'grey',
    },
    aboutMeIcon: {
        width: 20,
        height: 20,
    },
    workExperienceContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    workExperienceRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    workExperienceText: {
        fontSize: 14,
        color: 'grey',
    },
    workExperienceIcon: {
        width: 20,
        height: 20,
    },
    workItem: {
        marginVertical: 10,
    },
    workTitle: {
        fontWeight: 'bold',
    },
    workCompany: {
        color: 'grey',
    },
    workDates: {
        fontSize: 12,
        color: 'grey',
    },
    workDescription: {
        fontSize: 12,
        color: 'grey',
    },
    appreciationContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    appreciationRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    appreciationText: {
        fontSize: 14,
        color: 'grey',
    },
    appreciationIcon: {
        width: 20,
        height: 20,
    },
    appreciationItem: {
        marginVertical: 10,
    },
    appreciationTitle: {
        fontWeight: 'bold',
    },
    appreciationCategory: {
        color: 'grey',
    },
    appreciationDates: {
        fontSize: 12,
        color: 'grey',
    },
    appreciationDescription: {
        fontSize: 12,
        color: 'grey',
    },
    skillContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    skillRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    skillText: {
        fontSize: 14,
        color: 'grey',
    },
    skillIcon: {
        width: 20,
        height: 20,
    },
    skillItem: {
        marginVertical: 10,
    },
    skillTitle: {
        fontWeight: 'bold',
    },
    educationContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    educationRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    educationText: {
        fontSize: 14,
        color: 'grey',
    },
    educationIcon: {
        width: 20,
        height: 20,
    },
    languageContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    languageRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    languageText: {
        fontSize: 14,
        color: 'grey',
    },
    languageIcon: {
        width: 20,
        height: 20,
    },
    resumeContainer: {
        paddingVertical: 10,
        marginTop: 10,
    },
    resumeRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    resumeText: {
        fontSize: 14,
        color: 'grey',
    },
    resumeIcon: {
        width: 20,
        height: 20,
    },
});

export default ProfileScreen;
