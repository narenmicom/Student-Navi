import 'package:supabase_flutter/supabase_flutter.dart';

const url = 'https://zfkofzdawctajysziehp.supabase.co';

const anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpma29memRhd2N0YWp5c3ppZWhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU4NDYxNjQsImV4cCI6MTk5MTQyMjE2NH0.I_GbARbLFM4HU4AuzicpbWD8i4bCsAdvxxwL5kurKPM';

final SupabaseClient supabase = SupabaseClient(url, anonKey);
