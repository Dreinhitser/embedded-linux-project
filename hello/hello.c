#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/version.h>
#include <linux/utsname.h>

#define PROC_NAME "example"

static int proc_show(struct seq_file *m, void *v)
{
    seq_printf(m, "Hello from kernel procfs!\n");
    seq_printf(m, "Kernel version: %s\n", utsname()->release);
    seq_printf(m, "Current PID: %d\n", current->pid);
    return 0;
}

static int proc_open(struct inode *inode, struct file *file)
{
    return single_open(file, proc_show, NULL);
}

static const struct proc_ops proc_fops = {
    .proc_open = proc_open,
    .proc_read = seq_read,
    .proc_lseek = seq_lseek,
    .proc_release = single_release,
};

static int __init proc_init(void)
{
    proc_create(PROC_NAME, 0, NULL, &proc_fops);
    printk(KERN_INFO "Procfs example created at /proc/%s\n", PROC_NAME);
    return 0;
}

static void __exit proc_exit(void)
{
    remove_proc_entry(PROC_NAME, NULL);
    printk(KERN_INFO "Procfs example removed from /proc/%s\n", PROC_NAME);
}

module_init(proc_init);
module_exit(proc_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Dreinhitser");
MODULE_DESCRIPTION("Simple procfs example");