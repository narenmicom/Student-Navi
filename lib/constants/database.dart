import 'package:supabase_flutter/supabase_flutter.dart';

const url = 'https://zfkofzdawctajysziehp.supabase.co';

const anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpma29memRhd2N0YWp5c3ppZWhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU4NDYxNjQsImV4cCI6MTk5MTQyMjE2NH0.I_GbARbLFM4HU4AuzicpbWD8i4bCsAdvxxwL5kurKPM';
// const anonKey =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpma29memRhd2N0YWp5c3ppZWhwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3NTg0NjE2NCwiZXhwIjoxOTkxNDIyMTY0fQ.dihrmkiNIimEuHYda7nK66o_2wsdtXdUKb8k13VPmDQ';
const oneSignalAppID = "820e678b-8e24-4c66-aa58-dcd8021ceec8";

final SupabaseClient supabase = SupabaseClient(url, anonKey);
