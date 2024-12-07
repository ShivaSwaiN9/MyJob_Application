import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';
import 'react-native-gesture-handler';

enableScreens();
import {ProfileProvider} from './src/context/ProfileContext';
import SplashScreen from './src/screens/login/Splash';
import LoginScreen from './src/screens/login/Login';
import Register from './src/screens/login/Register';
import HomeScreen from './src/screens/home/HomeScreen';
import ApplyScreen from './src/screens/jobApplyScreen/ApplyScreen';
import UploadCV from './src/screens/jobApplyScreen/UploadCV';
import SavedJobsScreen from './src/screens/home/SavedJobsScreen';
import Organization from './src/screens/organization/Organization';
import JobSearchScreen from './src/screens/jobs/JobSearchScreen';
import Specialization from './src/screens/jobs/Specialization';
import NoSearches from './src/screens/jobs/NoSearches';
import Filter from './src/screens/jobs/Filter';
import MyProfile from './src/screens/completeProfile/MyProfile';
import Setting from './src/screens/completeProfile/Setting';
import RegisterDetails from './src/screens/login/RegisterDetails';
import PasswordScreen from './src/screens/completeProfile/PasswordScreen';
import ProfileScreen from './src/screens/profile/Profile';
import AboutMe from './src/screens/about/AboutMe';
import EditProfileScreen from './src/screens/profile/EditProfile';
import AddWorkExperience from './src/screens/workExperience/AddWorkExperience';
import LanguageScreen from './src/screens/organization/language/LanguageScreen';
import AddAppreciation from './src/screens/appreciation/AddAppreciation';
import AddResume from './src/screens/resume/AddResume';
import EditWorkExperience from './src/screens/workExperience/EditWorkExperience';
import EditAppreciation from './src/screens/appreciation/EditAppreciation';
import AddSkill from './src/screens/skill/AddSkill';
import SkillListScreen from './src/screens/skill/SkillListScreen';
import EditSkillScreen from './src/screens/skill/EditSkill';
import AddEducation from './src/screens/education/AddEducation';
import AddJobPage from './src/screens/organization/JobPost';
import JobPost from './src/screens/organization/JobPost';
import JobShare from './src/screens/organization/JobShare';
import NotificationScreen from './src/screens/notification/Notifications';
import { enableScreens } from 'react-native-screens';
import EditEducation from './src/screens/education/EditEducation';
import LanguageSelection from './src/screens/completeProfile/LanguageSelection';



const Stack = createStackNavigator();

const App = () => {
  return (
    <ProfileProvider>
      <NavigationContainer>
        <Stack.Navigator
          initialRouteName="Splash"
          screenOptions={{headerShown: false}}>
          <Stack.Screen name="Splash" component={SplashScreen} />
          <Stack.Screen name="Login" component={LoginScreen} />
          <Stack.Screen name="Register" component={Register} />
          <Stack.Screen name="RegisterDetails" component={RegisterDetails} />
          <Stack.Screen name="HomeScreen" component={HomeScreen} />
          <Stack.Screen name="ApplyScreen" component={ApplyScreen} />
          <Stack.Screen name="UploadCV" component={UploadCV} />
          <Stack.Screen name="SavedJobsScreen" component={SavedJobsScreen} />
          <Stack.Screen name="Organization" component={Organization} />
          <Stack.Screen name="JobSearchScreen" component={JobSearchScreen} />
          <Stack.Screen name="Specialization" component={Specialization} />
          <Stack.Screen name="NoSearches" component={NoSearches} />
          <Stack.Screen name="MyProfile" component={MyProfile} />
          <Stack.Screen name="Filter" component={Filter} />
          <Stack.Screen name="Setting" component={Setting} />
          <Stack.Screen name="PasswordScreen" component={PasswordScreen} />
          <Stack.Screen name="Profile" component={ProfileScreen} />
          <Stack.Screen name="EditProfile" component={EditProfileScreen} />
          <Stack.Screen name="AddWorkExperience" component={AddWorkExperience}/>
          <Stack.Screen name="AddAppreciation" component={AddAppreciation} />
          <Stack.Screen name="AddResume" component={AddResume} />
          <Stack.Screen name="LanguageScreen" component={LanguageScreen} />
          <Stack.Screen name="AboutMe" component={AboutMe} />
          <Stack.Screen name="EditWorkExperience" component={EditWorkExperience}/>
          <Stack.Screen name="EditAppreciation" component={EditAppreciation} />
            <Stack.Screen name="EditEducation" component={EditEducation} />
          <Stack.Screen name="AddSkill" component={AddSkill} />
          <Stack.Screen name="SkillList" component={SkillListScreen} />
          <Stack.Screen name="EditSkillScreen" component={EditSkillScreen} />
          <Stack.Screen name="AddEducation" component={AddEducation} />
          <Stack.Screen name="JobPage" component={AddJobPage} />
          <Stack.Screen name="JobPost"  component={JobPost} />
        <Stack.Screen name="JobShare" component={JobShare} />
        <Stack.Screen name="Notifications" component={NotificationScreen} /> 
        <Stack.Screen name="LanguageSelection" component={LanguageSelection} /> 
        </Stack.Navigator>
      </NavigationContainer>
    </ProfileProvider>
  );
};

export default App;
