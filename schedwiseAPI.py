import random
import logging
from datetime import time, datetime
from dataclasses import dataclass
from typing import List, Dict, Optional, Set, Tuple
from collections import defaultdict
from abc import ABC, abstractmethod

# Configure logging
logging.basicConfig(level=logging.INFO)

@dataclass(frozen=True)
class TimeSlot:
    start_time: time
    end_time: time
    
    def __hash__(self):
        return hash((self.start_time, self.end_time))
    
    def __eq__(self, other):
        if not isinstance(other, TimeSlot):
            return False
        return self.start_time == other.start_time and self.end_time == other.end_time

@dataclass
class Room:
    room_id: int
    room_name: str
    room_type: str
    capacity: int
    program_id: Optional[int] = None

@dataclass
class Faculty:
    faculty_id: int
    faculty_name: str
    employment_type: str
    specialization: Optional[str] = None
    total_units: Optional[int] = None
    total_equivalent_units: Optional[float] = None
    total_hours: Optional[str] = None
    program_id: Optional[int] = None

@dataclass
class Course:
    course_id: int
    course_code: str
    descriptive_title: str
    units: int
    course_type: str = 'Major'
    year_level: int = 1
    semester: str = '1st Sem'
    program_id: Optional[int] = None

@dataclass
class Section:
    section_id: int
    section_name: str
    program_id: int
    year_level: int

@dataclass
class Program:
    program_id: int
    program_code: str
    program_name: str

@dataclass
class ScheduleItem:
    faculty_id: int
    course_id: int
    section_id: int
    room_id: int
    time_slot: TimeSlot
    day: str
    delivery_mode: str
    session_type: str

class DataProvider(ABC):
    """Abstract interface for data access"""
    
    @abstractmethod
    def get_rooms(self) -> List[Room]:
        pass
    
    @abstractmethod
    def get_faculty(self) -> List[Faculty]:
        pass
    
    @abstractmethod
    def get_courses(self) -> List[Course]:
        pass
    
    @abstractmethod
    def get_sections(self) -> List[Section]:
        pass
    
    @abstractmethod
    def get_programs(self) -> List[Program]:
        pass

class ConstraintChecker:
    """Handles all constraint validation for scheduling"""
    
    def __init__(self):
        self.faculty_schedules = {}  # faculty_id -> {day -> [time_slots]}
        self.room_schedules = {}     # room_id -> {day -> [time_slots]}
        self.section_schedules = {}  # section_id -> {day -> [time_slots]}
    
    def initialize_schedules(self, faculty: List[Faculty], rooms: List[Room], sections: List[Section], weekdays: List[str]):
        """Initialize empty schedules for all resources"""
        for f in faculty:
            self.faculty_schedules[f.faculty_id] = {day: [] for day in weekdays}
        
        for r in rooms:
            self.room_schedules[r.room_id] = {day: [] for day in weekdays}
        
        for s in sections:
            self.section_schedules[s.section_id] = {day: [] for day in weekdays}
    
    def check_conflicts(self, faculty_id: int, room_id: int, section_id: int, day: str, time_slot: TimeSlot, rooms: List[Room]) -> Tuple[bool, Optional[str]]:
        """Check for scheduling conflicts"""
        # Check faculty conflict
        if faculty_id in self.faculty_schedules:
            for existing_slot in self.faculty_schedules[faculty_id][day]:
                if self._time_slots_overlap(time_slot, existing_slot):
                    return True, "faculty"
        
        # Check room conflict (only for physical rooms)
        room = next((r for r in rooms if r.room_id == room_id), None)
        if room and room.room_type.lower() != 'online':
            if room_id in self.room_schedules:
                for existing_slot in self.room_schedules[room_id][day]:
                    if self._time_slots_overlap(time_slot, existing_slot):
                        return True, "room"
        
        # Check section conflict
        if section_id in self.section_schedules:
            for existing_slot in self.section_schedules[section_id][day]:
                if self._time_slots_overlap(time_slot, existing_slot):
                    return True, "section"
        
        return False, None
    
    def add_schedule(self, faculty_id: int, room_id: int, section_id: int, day: str, time_slot: TimeSlot):
        """Add a time slot to the schedules"""
        self.faculty_schedules[faculty_id][day].append(time_slot)
        self.room_schedules[room_id][day].append(time_slot)
        self.section_schedules[section_id][day].append(time_slot)
    
    def _time_slots_overlap(self, slot1: TimeSlot, slot2: TimeSlot) -> bool:
        """Check if two time slots overlap"""
        return not (slot1.end_time <= slot2.start_time or slot2.end_time <= slot1.start_time)

class LoadBalancer:
    """Manages faculty workload distribution"""
    
    def __init__(self):
        self.faculty_loads = {}  # faculty_id -> {'sections': count, 'courses': count, 'time_slots': count}
        self.faculty_course_assignments = {}  # faculty_id -> [course_codes]
        self.faculty_section_assignments = {}  # faculty_id -> [section_ids]
    
    def initialize_loads(self, faculty: List[Faculty]):
        """Initialize load tracking for all faculty"""
        for f in faculty:
            self.faculty_loads[f.faculty_id] = {'sections': 0, 'courses': 0, 'time_slots': 0}
            self.faculty_course_assignments[f.faculty_id] = []
            self.faculty_section_assignments[f.faculty_id] = []
    
    def get_load_score(self, faculty_id: int) -> int:
        """Calculate faculty load score (higher means more loaded)"""
        if faculty_id not in self.faculty_loads:
            return 0
        
        load = self.faculty_loads[faculty_id]
        # Weighted score: sections (3x), courses (2x), time_slots (1x)
        return (load['sections'] * 3) + (load['courses'] * 2) + (load['time_slots'] * 1)
    
    def is_faculty_available(self, faculty_id: int) -> bool:
        """Check if faculty has available capacity"""
        if faculty_id not in self.faculty_loads:
            return True
        
        load = self.faculty_loads[faculty_id]
        return (load['sections'] < 5 and 
                load['courses'] < 10 and 
                load['time_slots'] < 14)
    
    def update_load(self, faculty_id: int, sections_change: int = 0, courses_change: int = 0, time_slots_change: int = 0):
        """Update faculty load tracking"""
        if faculty_id not in self.faculty_loads:
            self.faculty_loads[faculty_id] = {'sections': 0, 'courses': 0, 'time_slots': 0}
        
        self.faculty_loads[faculty_id]['sections'] += sections_change
        self.faculty_loads[faculty_id]['courses'] += courses_change
        self.faculty_loads[faculty_id]['time_slots'] += time_slots_change
    
    def assign_course_to_faculty(self, faculty_id: int, course_code: str):
        """Track course assignment to faculty"""
        if course_code not in self.faculty_course_assignments[faculty_id]:
            self.faculty_course_assignments[faculty_id].append(course_code)
            self.update_load(faculty_id, courses_change=1)
    
    def assign_section_to_faculty(self, faculty_id: int, section_id: int):
        """Track section assignment to faculty"""
        if section_id not in self.faculty_section_assignments[faculty_id]:
            self.faculty_section_assignments[faculty_id].append(section_id)
            self.update_load(faculty_id, sections_change=1)

class FacultyMatcher:
    """Handles faculty-course matching based on specialization"""
    
    def find_best_faculty(self, course: Course, section: Section, faculty: List[Faculty], load_balancer: LoadBalancer) -> Optional[Faculty]:
        """Find the best faculty for a course with specialization matching and load balancing"""
        # Get faculty sorted by load (ascending) for better distribution
        faculty_loads = []
        for f in faculty:
            load_score = load_balancer.get_load_score(f.faculty_id)
            faculty_loads.append((f, load_score))
        
        # Sort by load score (ascending - least loaded first)
        faculty_loads.sort(key=lambda x: x[1])
        
        # Priority 1: Faculty with exact course code in specialization
        for f, load_score in faculty_loads:
            if (f.specialization and 
                course.course_code.upper() in f.specialization.upper() and 
                load_balancer.is_faculty_available(f.faculty_id)):
                return f
        
        # Priority 2: Faculty with course keywords in specialization
        course_keywords = course.course_code.upper().split()
        for f, load_score in faculty_loads:
            if f.specialization:
                specialization_upper = f.specialization.upper()
                for keyword in course_keywords:
                    if (keyword in specialization_upper and 
                        load_balancer.is_faculty_available(f.faculty_id)):
                        return f
        
        # Priority 3: Faculty with descriptive title keywords in specialization
        title_keywords = course.descriptive_title.upper().split()
        for f, load_score in faculty_loads:
            if f.specialization:
                specialization_upper = f.specialization.upper()
                for keyword in title_keywords:
                    if (keyword in specialization_upper and 
                        load_balancer.is_faculty_available(f.faculty_id)):
                        return f
        
        # Priority 4: Faculty from same program and within limits
        for f, load_score in faculty_loads:
            if (f.program_id == section.program_id and 
                load_balancer.is_faculty_available(f.faculty_id)):
                return f
        
        # Priority 5: Any available faculty within limits
        for f, load_score in faculty_loads:
            if load_balancer.is_faculty_available(f.faculty_id):
                return f
        
        return None

class RoomAllocator:
    """Handles room allocation logic"""
    
    def get_suitable_rooms(self, program_id: int, course_type: str, rooms: List[Room]) -> List[Room]:
        """Get suitable rooms for a course based on program and type"""
        program_rooms = []
        general_rooms = []
        laboratory_rooms = []
        
        for room in rooms:
            if room.room_type.lower() not in ['online', 'field', 'tba']:
                if room.program_id == program_id:
                    if room.room_type.lower() == 'laboratory':
                        laboratory_rooms.append(room)
                    else:
                        program_rooms.append(room)
                elif room.program_id is None:
                    if room.room_type.lower() == 'laboratory':
                        laboratory_rooms.append(room)
                    else:
                        general_rooms.append(room)
        
        # For minor courses, prioritize laboratory rooms
        if course_type.lower() == 'minor':
            random.shuffle(laboratory_rooms)
            random.shuffle(program_rooms)
            random.shuffle(general_rooms)
            return laboratory_rooms + program_rooms + general_rooms
        else:
            all_rooms = program_rooms + general_rooms + laboratory_rooms
            random.shuffle(all_rooms)
            return all_rooms
    
    def get_online_room(self, rooms: List[Room], program_id: int) -> Room:
        """Get or create an online room"""
        online_room = next((r for r in rooms if r.room_type.lower() == 'online'), None)
        if not online_room:
            # Find a high room_id that doesn't exist to avoid conflicts
            max_room_id = max([r.room_id for r in rooms]) if rooms else 0
            virtual_room_id = max_room_id + 1000  # Use a high ID to avoid conflicts
            
            online_room = Room(
                room_id=virtual_room_id,
                room_name='Online',
                room_type='Online',
                capacity=999,
                program_id=program_id
            )
        return online_room

class TimeSlotGenerator:
    """Generates and manages time slots"""
    
    def generate_time_slots(self) -> List[TimeSlot]:
        """Generate 1.5-hour (90-minute) time slots from 7:30 AM to 6:00 PM"""
        time_slots = []
        
        start_hour = 7
        start_minute = 30
        
        current_hour = start_hour
        current_minute = start_minute
        
        while current_hour < 18:
            start_time = time(current_hour, current_minute)
            
            end_hour = current_hour
            end_minute = current_minute + 90
            
            while end_minute >= 60:
                end_hour += 1
                end_minute -= 60
            
            end_time = time(end_hour, end_minute)
            
            if end_hour >= 18:
                break
            
            time_slots.append(TimeSlot(start_time, end_time))
            
            current_minute += 90
            while current_minute >= 60:
                current_hour += 1
                current_minute -= 60
        
        return time_slots

class SchedulingAlgorithm:
    """Main scheduling algorithm using constraint satisfaction and heuristic optimization"""
    
    def __init__(self, data_provider: DataProvider):
        self.data_provider = data_provider
        self.weekdays = ['M', 'T', 'W', 'TH', 'F']
        
        # Algorithm components
        self.constraint_checker = ConstraintChecker()
        self.load_balancer = LoadBalancer()
        self.faculty_matcher = FacultyMatcher()
        self.room_allocator = RoomAllocator()
        self.time_slot_generator = TimeSlotGenerator()
        
        # Data
        self.rooms = []
        self.faculty = []
        self.courses = []
        self.sections = []
        self.programs = []
        self.time_slots = []
        
        # Results
        self.generated_schedules = []
    
    def initialize(self):
        """Load data and initialize algorithm components"""
        # Load data
        self.rooms = self.data_provider.get_rooms()
        self.faculty = self.data_provider.get_faculty()
        self.courses = self.data_provider.get_courses()
        self.sections = self.data_provider.get_sections()
        self.programs = self.data_provider.get_programs()
        
        # Generate time slots
        self.time_slots = self.time_slot_generator.generate_time_slots()
        
        # Initialize components
        self.constraint_checker.initialize_schedules(self.faculty, self.rooms, self.sections, self.weekdays)
        self.load_balancer.initialize_loads(self.faculty)
        
        logging.info(f"Algorithm initialized with {len(self.rooms)} rooms, {len(self.faculty)} faculty, "
                    f"{len(self.courses)} courses, {len(self.sections)} sections")
    
    def generate_schedule(self) -> List[ScheduleItem]:
        """Main algorithm to generate class schedules"""
        self.generated_schedules = []
        
        # Group sections by year level and program
        sections_by_year_program = self._group_sections()
        
        # Process each year level and program
        for year_level in sorted(sections_by_year_program.keys()):
            for program_id in sections_by_year_program[year_level]:
                self._process_program_sections(year_level, program_id, sections_by_year_program[year_level][program_id])
        
        logging.info(f"Generated {len(self.generated_schedules)} schedule items")
        return self.generated_schedules
    
    def _group_sections(self) -> Dict[int, Dict[int, List[Section]]]:
        """Group sections by year level and program"""
        sections_by_year_program = defaultdict(lambda: defaultdict(list))
        for section in self.sections:
            sections_by_year_program[section.year_level][section.program_id].append(section)
        return sections_by_year_program
    
    def _process_program_sections(self, year_level: int, program_id: int, sections: List[Section]):
        """Process sections for a specific program and year level"""
        program = next((p for p in self.programs if p.program_id == program_id), None)
        if not program:
            return
        
        logging.info(f"Processing {program.program_name} - Year {year_level}: {len(sections)} sections")
        
        # Get courses for this program and year level
        program_courses = self._get_courses_for_program_and_year(program_id, year_level)
        
        if not program_courses:
            logging.warning(f"No courses found for {program.program_name} - Year {year_level}")
            return
        
        # Assign courses to each section
        for section in sections:
            self._assign_courses_to_section(section, program_courses)
    
    def _get_courses_for_program_and_year(self, program_id: int, year_level: int) -> List[Course]:
        """Get courses for a specific program and year level"""
        program_courses = []
        
        # Get major courses for this program and year
        for course in self.courses:
            if (course.program_id == program_id and course.year_level == year_level and 
                course.course_type.lower() == 'major'):
                program_courses.append(course)
        
        # Add minor courses for this year level
        for course in self.courses:
            if (course.year_level == year_level and course.course_type.lower() == 'minor'):
                program_courses.append(course)
        
        # Add general courses (no specific program)
        for course in self.courses:
            if (course.year_level == year_level and course.program_id is None and 
                course.course_type.lower() not in ['major', 'minor']):
                program_courses.append(course)
        
        return program_courses
    
    def _assign_courses_to_section(self, section: Section, courses: List[Course]):
        """Assign courses to a specific section"""
        # Limit courses per section (max 6 courses)
        max_courses = min(6, len(courses))
        section_courses = courses[:max_courses]
        
        for course in section_courses:
            # Find best faculty for this course
            faculty = self.faculty_matcher.find_best_faculty(course, section, self.faculty, self.load_balancer)
            
            if faculty:
                self._assign_course_sessions(course, section, faculty)
            else:
                logging.warning(f"No available faculty found for course {course.course_code}")
    
    def _assign_course_sessions(self, course: Course, section: Section, faculty: Faculty):
        """Assign both face-to-face and online sessions for a course"""
        # Track assignments
        self.load_balancer.assign_course_to_faculty(faculty.faculty_id, course.course_code)
        self.load_balancer.assign_section_to_faculty(faculty.faculty_id, section.section_id)
        
        # Get suitable rooms
        suitable_rooms = self.room_allocator.get_suitable_rooms(section.program_id, course.course_type, self.rooms)
        
        # Assign face-to-face session
        f2f_success = self._assign_session(course, section, faculty, suitable_rooms, 'Face-to-face')
        
        # For online session, try to find an existing online room first
        online_rooms = [r for r in self.rooms if r.room_type.lower() == 'online']
        if not online_rooms:
            # Create virtual online room and add to rooms list for this session
            online_room = self.room_allocator.get_online_room(self.rooms, section.program_id)
            # Add virtual room to the rooms list so it can be found during assignment
            self.rooms.append(online_room)
            online_rooms = [online_room]
        
        # Assign online session
        online_success = self._assign_session(course, section, faculty, online_rooms, 'Online')
        
        # Update time slots if both sessions were successful
        if f2f_success and online_success:
            self.load_balancer.update_load(faculty.faculty_id, time_slots_change=2)
            
        return f2f_success and online_success
    
    def _assign_session(self, course: Course, section: Section, faculty: Faculty, 
                       available_rooms: List[Room], delivery_mode: str) -> bool:
        """Assign a single session (either face-to-face or online)"""
        # Shuffle for randomization
        shuffled_days = self.weekdays.copy()
        shuffled_time_slots = self.time_slots.copy()
        random.shuffle(shuffled_days)
        random.shuffle(shuffled_time_slots)
        random.shuffle(available_rooms)
        
        for day in shuffled_days:
            for time_slot in shuffled_time_slots:
                for room in available_rooms:
                    # Check for conflicts
                    has_conflict, conflict_type = self.constraint_checker.check_conflicts(
                        faculty.faculty_id, room.room_id, section.section_id, day, time_slot, self.rooms
                    )
                    
                    if not has_conflict:
                        # Create schedule item
                        schedule_item = ScheduleItem(
                            faculty_id=faculty.faculty_id,
                            course_id=course.course_id,
                            section_id=section.section_id,
                            room_id=room.room_id,
                            time_slot=time_slot,
                            day=day,
                            delivery_mode=delivery_mode,
                            session_type='lab' if room.room_type.lower() == 'laboratory' else 'lecture'
                        )
                        
                        # Add to schedules
                        self.constraint_checker.add_schedule(faculty.faculty_id, room.room_id, section.section_id, day, time_slot)
                        self.generated_schedules.append(schedule_item)
                        
                        logging.info(f"Assigned {course.course_code} ({delivery_mode}) to {section.section_name} "
                                   f"on {day} {time_slot.start_time}-{time_slot.end_time}")
                        return True
        
        logging.warning(f"Failed to assign {course.course_code} ({delivery_mode}) to {section.section_name}")
        return False
    
    def get_schedule_summary(self) -> Dict:
        """Get summary statistics of the generated schedule"""
        return {
            'total_schedule_items': len(self.generated_schedules),
            'faculty_loads': self.load_balancer.faculty_loads,
            'faculty_assignments': self.load_balancer.faculty_course_assignments,
            'constraint_violations': 0  # Would implement proper violation counting
        }

import mysql.connector
import requests

class DatabaseDataProvider(DataProvider):
    """Concrete implementation of DataProvider that fetches data from MySQL database"""
    
    def __init__(self, db_config: Optional[Dict] = None):
        self.db_config = db_config or self._get_database_config()
        self.connection = None
    
    def _get_database_config(self) -> Dict:
        """Get database configuration"""
        try:
            # Try to get config from PHP endpoint
            response = requests.get('http://localhost/schedwiseAPI/config/database.php')
            if response.status_code == 200:
                config = response.json()
                return {
                    'host': config.get('host', 'localhost'),
                    'user': config.get('user', 'root'),
                    'password': config.get('password', ''),
                    'database': config.get('database', 'schedwise')
                }
        except Exception as e:
            logging.warning(f"Could not fetch database config from PHP: {e}")
        
        # Fallback to default configuration
        return {
            'host': 'localhost',
            'user': 'root',
            'password': '',
            'database': 'schedwise'
        }
    
    def _get_connection(self):
        """Get database connection"""
        if not self.connection or not self.connection.is_connected():
            self.connection = mysql.connector.connect(**self.db_config)
        return self.connection
    
    def get_rooms(self) -> List[Room]:
        """Fetch rooms from database"""
        try:
            conn = self._get_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT room_id, room_name, room_type, capacity, program_id FROM Rooms")
            rooms_data = cursor.fetchall()
            cursor.close()
            return [Room(**row) for row in rooms_data]
        except Exception as e:
            logging.error(f"Error fetching rooms: {e}")
            return []
    
    def get_faculty(self) -> List[Faculty]:
        """Fetch faculty from database"""
        try:
            conn = self._get_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("""
                SELECT faculty_id, faculty_name, employment_type, specialization, 
                       total_units, total_equivalent_units, total_hours, program_id 
                FROM Faculty
            """)
            faculty_data = cursor.fetchall()
            cursor.close()
            return [Faculty(**row) for row in faculty_data]
        except Exception as e:
            logging.error(f"Error fetching faculty: {e}")
            return []
    
    def get_courses(self) -> List[Course]:
        """Fetch courses from database"""
        try:
            conn = self._get_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("""
                SELECT course_id, course_code, descriptive_title, units, course_type, 
                       year_level, semester, program_id 
                FROM Courses
            """)
            courses_data = cursor.fetchall()
            cursor.close()
            return [Course(**row) for row in courses_data]
        except Exception as e:
            logging.error(f"Error fetching courses: {e}")
            return []
    
    def get_sections(self) -> List[Section]:
        """Fetch sections from database"""
        try:
            conn = self._get_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT section_id, section_name, program_id, year_level FROM Sections")
            sections_data = cursor.fetchall()
            cursor.close()
            return [Section(**row) for row in sections_data]
        except Exception as e:
            logging.error(f"Error fetching sections: {e}")
            return []
    
    def get_programs(self) -> List[Program]:
        """Fetch programs from database"""
        try:
            conn = self._get_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT program_id, program_code, program_name FROM Programs")
            programs_data = cursor.fetchall()
            cursor.close()
            return [Program(**row) for row in programs_data]
        except Exception as e:
            logging.error(f"Error fetching programs: {e}")
            return []
    
    def close_connection(self):
        """Close database connection"""
        if self.connection and self.connection.is_connected():
            self.connection.close()

class ScheduleRepository:
    """Handles saving generated schedules back to the database"""
    
    def __init__(self, data_provider: DatabaseDataProvider):
        self.data_provider = data_provider
    
    def save_schedules(self, schedule_items: List[ScheduleItem], 
                      faculty_list: List[Faculty], courses_list: List[Course], 
                      rooms_list: List[Room]) -> int:
        """Save generated schedules to the database"""
        try:
            conn = self.data_provider._get_connection()
            cursor = conn.cursor()
            
            # Clear existing schedules first
            cursor.execute("DELETE FROM ClassSchedules")
            logging.info("Cleared existing schedules")
            
            saved_count = 0
            for item in schedule_items:
                try:
                    # Find related entities
                    faculty = next((f for f in faculty_list if f.faculty_id == item.faculty_id), None)
                    course = next((c for c in courses_list if c.course_id == item.course_id), None)
                    room = next((r for r in rooms_list if r.room_id == item.room_id), None)
                    
                    if not faculty:
                        logging.error(f"Faculty not found for ID: {item.faculty_id}")
                        continue
                    if not course:
                        logging.error(f"Course not found for ID: {item.course_id}")
                        continue
                    if not room:
                        # Handle virtual online rooms - skip saving if room doesn't exist in database
                        if item.delivery_mode.lower() == 'online':
                            logging.warning(f"Virtual online room ID {item.room_id} not in database, skipping save")
                            continue
                        else:
                            logging.error(f"Physical room not found for ID: {item.room_id}")
                            continue
                    
                    # Insert schedule into database
                    insert_sql = """
                        INSERT INTO ClassSchedules
                        (faculty_id, course_id, section_id, room_id, time_start, time_end, 
                         days, delivery_mode, equivalent_units)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """
                    
                    values = (
                        item.faculty_id,
                        item.course_id,
                        item.section_id,
                        item.room_id,
                        item.time_slot.start_time.strftime('%H:%M:%S'),
                        item.time_slot.end_time.strftime('%H:%M:%S'),
                        item.day,
                        item.delivery_mode,
                        course.units
                    )
                    
                    logging.debug(f"Inserting: {values}")
                    cursor.execute(insert_sql, values)
                    saved_count += 1
                    
                except Exception as item_error:
                    logging.error(f"Error saving individual schedule item: {item_error}")
                    logging.error(f"Item details: Faculty={item.faculty_id}, Course={item.course_id}, "
                                f"Section={item.section_id}, Room={item.room_id}, Day={item.day}")
                    continue
            
            # Commit the transaction
            conn.commit()
            cursor.close()
            
            logging.info(f"Saved {saved_count} out of {len(schedule_items)} schedule items to database")
            return saved_count
            
        except Exception as e:
            logging.error(f"Error saving schedules to database: {e}")
            logging.error(f"Error type: {type(e).__name__}")
            if 'conn' in locals() and conn:
                conn.rollback()
            raise

# Complete scheduling system with database integration
class SchedulingSystem:
    """Complete scheduling system that integrates algorithm with database operations"""
    
    def __init__(self, db_config: Optional[Dict] = None):
        self.data_provider = DatabaseDataProvider(db_config)
        self.algorithm = SchedulingAlgorithm(self.data_provider)
        self.repository = ScheduleRepository(self.data_provider)
    
    def generate_and_save_schedules(self) -> Dict:
        """Complete workflow: generate schedules and save to database"""
        try:
            # Initialize algorithm with database data
            logging.info("Loading data from database...")
            self.algorithm.initialize()
            
            # Check if we have an online room in database, if not create one
            self._ensure_online_room_exists()
            
            # Generate schedules
            logging.info("Generating schedules...")
            schedule_items = self.algorithm.generate_schedule()
            
            if not schedule_items:
                return {
                    'success': False,
                    'error': 'No schedules were generated',
                    'total_items': 0,
                    'generated_at': datetime.now().isoformat()
                }
            
            # Filter out schedules with virtual rooms that don't exist in database
            valid_schedule_items = self._filter_valid_schedules(schedule_items)
            
            if not valid_schedule_items:
                return {
                    'success': False,
                    'error': 'No valid schedules to save (all had virtual rooms)',
                    'total_items': len(schedule_items),
                    'generated_at': datetime.now().isoformat()
                }
            
            # Save to database
            logging.info(f"Saving {len(valid_schedule_items)} valid schedules to database...")
            saved_count = self.repository.save_schedules(
                valid_schedule_items,
                self.algorithm.faculty,
                self.algorithm.courses,
                self.algorithm.rooms
            )
            
            # Get summary
            summary = self.algorithm.get_schedule_summary()
            summary['valid_items'] = len(valid_schedule_items)
            summary['total_generated'] = len(schedule_items)
            
            return {
                'success': True,
                'total_items': len(schedule_items),
                'valid_items': len(valid_schedule_items),
                'saved_count': saved_count,
                'summary': summary,
                'generated_at': datetime.now().isoformat()
            }
            
        except Exception as e:
            logging.error(f"Error in scheduling system: {e}")
            import traceback
            traceback.print_exc()
            return {
                'success': False,
                'error': str(e),
                'total_items': 0,
                'generated_at': datetime.now().isoformat()
            }
        finally:
            self.data_provider.close_connection()
    
    def _ensure_online_room_exists(self):
        """Ensure there's an online room in the database"""
        online_rooms = [r for r in self.algorithm.rooms if r.room_type.lower() == 'online']
        if not online_rooms:
            logging.info("No online room found in database, creating one...")
            try:
                conn = self.data_provider._get_connection()
                cursor = conn.cursor()
                
                # Insert online room into database
                cursor.execute("""
                    INSERT INTO Rooms (room_name, room_type, capacity, program_id) 
                    VALUES ('Online Classroom', 'Online', 999, NULL)
                """)
                
                # Get the inserted room ID
                online_room_id = cursor.lastrowid
                
                # Add to our rooms list
                online_room = Room(
                    room_id=online_room_id,
                    room_name='Online Classroom',
                    room_type='Online',
                    capacity=999,
                    program_id=None
                )
                self.algorithm.rooms.append(online_room)
                
                conn.commit()
                cursor.close()
                
                logging.info(f"Created online room with ID: {online_room_id}")
                
            except Exception as e:
                logging.error(f"Failed to create online room: {e}")
                if 'conn' in locals():
                    conn.rollback()
    
    def _filter_valid_schedules(self, schedule_items: List[ScheduleItem]) -> List[ScheduleItem]:
        """Filter out schedules that reference rooms not in database"""
        valid_items = []
        room_ids = {room.room_id for room in self.algorithm.rooms}
        
        for item in schedule_items:
            if item.room_id in room_ids:
                valid_items.append(item)
            else:
                logging.warning(f"Skipping schedule item with invalid room_id: {item.room_id}")
        
        return valid_items

# Example usage
if __name__ == "__main__":
    # Create and run the complete scheduling system
    scheduling_system = SchedulingSystem()
    
    result = scheduling_system.generate_and_save_schedules()
    
    if result['success']:
        print(f"✓ Successfully generated and saved {result['saved_count']} schedule items")
        print(f"Summary: {result['summary']}")
    else:
        print(f"✗ Scheduling failed: {result['error']}")
        
    print(f"Process completed at: {result.get('generated_at', 'Unknown time')}")